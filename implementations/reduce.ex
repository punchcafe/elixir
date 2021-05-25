defmodule PunchCafe.Enum do
    def reduce([], initial_val, _fun), do: initial_val

    def reduce([head|tail], initial_val, fun) do
        new_val = fun.(initial_val, head)
        reduce(tail, new_val, fun)
    end
end