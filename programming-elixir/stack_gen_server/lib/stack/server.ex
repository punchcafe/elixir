defmodule Stack.Server do

  use GenServer

  def start_link() do
    GenServer.start_link(__MODULE__, nil, name: __MODULE__)
  end

  @impl GenServer
  def init(_) do
    cached_stack = GenServer.call(Stack.Cache, :retrieve) 
    {:ok, if(cached_stack, do: cached_stack, else: [])}
  end

  @impl GenServer
  def handle_cast({:push, val}, state) do
    {:noreply, [val | state]}
  end

  @impl GenServer
  def handle_call(:pop, _caller, [top | stack]) do
    {:reply, top, stack}
  end

  @impl GenServer
  def terminate(_reason, state) do
    GenServer.cast(Stack.Cache, {:stash, state})
  end
end