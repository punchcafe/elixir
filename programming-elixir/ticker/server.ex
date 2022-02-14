defmodule Ticker.Server do

    @global_server_name :ticker_server

    def start() do
        pid = spawn(fn -> proccess {[], []} end)
        :global.register_name(@global_server_name, pid)
    end

    def proccess({clients, next_client_list}) do
      receive do
        {:join, pid} -> 
            IO.inspect("new joiner!")
            proccess({[pid | clients], next_client_list})
        after 2_000 -> 
          IO.inspect("timeout!")
          clients |> tick(next_client_list) |> proccess()
      end
    end

    defp tick([], []), do: {[], []}
    defp tick(clients, []), do: tick(clients, clients)
    defp tick(clients, [next_reciever | waiting_receivers ]) do
        send(next_reciever, :tick)
        {clients, waiting_receivers}
    end
end

defmodule Tick.Client do
@global_server_name :ticker_server
    def join() do
        @global_server_name
        |> :global.whereis_name()
        |> send({:join, self()})
        run()
    end

    defp run() do
        receive do
            :tick -> IO.inspect("ticked")
        end
    end
end
