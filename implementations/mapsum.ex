defmodule PunchCafe.Enum do
    def mapsum([], _map_func), do: 0
    def mapsum([head|tail], map_func) do 
        map_func.(head) + mapsum(tail, map_func)
    end
end

IO.inspect(PunchCafe.Enum.mapsum([1,2,3,4,5], &(&1*&1)))