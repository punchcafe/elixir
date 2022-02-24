defmodule Stack do

  def pop(), do: GenServer.call(__MODULE__.Server, :pop)
  def push(value), do: GenServer.cast(__MODULE__.Server, {:push, value})

end
