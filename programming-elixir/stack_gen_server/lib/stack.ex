defmodule Stack do

  def start_link, do: Stack.Application.start_link()
  def pop(), do: GenServer.call(__MODULE__.Server, :pop)
  def push(value), do: GenServer.cast(__MODULE__.Server, {:push, value})

end
