defmodule Stack.Server do

  use GenServer

  @impl GenServer
  def init(initial_stack) when is_list(initial_stack) do
    {:ok, initial_stack}
  end

  @impl GenServer
  def handle_cast({:push, val}, state) do
    {:noreply, [val | state]}
  end

  @impl GenServer
  def handle_call(:pop, _caller, [top | stack]) do
    {:reply, top, stack}
  end
end