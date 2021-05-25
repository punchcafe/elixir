defmodule PunchCafe.Enum do
    def max([]), do: 0
    def max(collection) do
        max_recursive(collection, 0)
    end
    defp max_recursive([], current_max), do: current_max
    defp max_recursive([head|tail], current_max) do
      if head > current_max, do: max_recursive(tail, head), else: max_recursive(tail, current_max)
    end
end

IO.puts(PunchCafe.Enum.max([1,2,10,3]))