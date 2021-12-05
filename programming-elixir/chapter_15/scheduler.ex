defmodule Scheduler do

  @behaviour Schedulable
  @type job :: {module(), atom(), list()}

  def schedule(jobs, opts \\ []) do
    number_of_workers = opts[:number_of_processes] || 1
    workers = 1..number_of_workers
    |> Enum.map(fn _ -> spawn(&do_work/0) end)

    remaining_jobs = send_all_workers_jobs(jobs, workers)
    allocate_remaining_jobs(remaining_jobs, [], length(workers))
  end

  defp allocate_remaining_jobs([], results, 0) do
    results
  end

  defp allocate_remaining_jobs([next_job | remaining_jobs], results, active_workers) do
    receive do
      {:done, worker, result} -> send(worker, {:job, self, next_job})
        allocate_remaining_jobs(remaining_jobs,[result | results], active_workers )
    end
  end

  defp allocate_remaining_jobs([], results, active_workers) do
    receive do
      {:done, worker, result} -> send(worker, :goodnight)
        allocate_remaining_jobs([],[result | results], active_workers - 1)
    end
  end

  defp send_all_workers_jobs([], _workers), do: []
  defp send_all_workers_jobs(jobs, []), do: jobs
  defp send_all_workers_jobs([next_job | other_jobs], [next_worker | other_workers]) do
    send(next_worker, {:job, self(), next_job})
    send_all_workers_jobs(other_jobs, other_workers)
  end

  defp do_work() do
    receive do
      {:job, scheduler, {mod, function, args}} ->
        send(scheduler, {:done, self(), apply(mod, function, args)})
        do_work()
      :goodnight -> :goodbye
    end
  end
end
