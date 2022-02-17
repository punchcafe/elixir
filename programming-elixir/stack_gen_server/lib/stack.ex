defmodule Stack do

  def start_link(stack) do
    GenServer.start_link(__MODULE__.Server, stack, name: __MODULE__)
  end

  def pop(), do: GenServer.call(__MODULE__, :pop)
  def push(value), do: GenServer.cast(__MODULE__, {:push, value})

end
