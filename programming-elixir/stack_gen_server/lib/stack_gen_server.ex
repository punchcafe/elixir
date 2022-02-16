defmodule Stack do

  use GenServer

  def start(stack) do
    GenServer.start_link(__MODULE__, stack, name: __MODULE__)
  end

  def pop(), do: GenServer.call(__MODULE__, :pop)
  def push(value), do: GenServer.cast(__MODULE__, {:push, value})

  #GenServer behaviour

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
