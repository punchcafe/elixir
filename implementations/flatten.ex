defmodule PunchCafe.Enum do
    def flatten(list_of_sublist) do
        flatten_recur(list_of_sublist, [])
        |> Enum.reverse()
    end

    defp flatten_recur([], accum), do: accum
    defp flatten_recur([ head | tail ], accum) do
        result = if is_list(head), do: flatten_recur(head, []), else: [head]
        flatten_recur(tail, accum) ++ result
    end
end
IO.inspect(PunchCafe.Enum.flatten([1,2,[3,[4,5], 6, 7 ,[8, 9]]]))