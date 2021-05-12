defmodule PunchCafe.Enum do
  def map(list, operation) do
    do_map(list, operation, [])
  end

  defp do_map(list, _operation, accum) when length(list) == 0 do
    accum
  end

  defp do_map(list, operation, accum) do
    [head|tail] = list
    transformed_head = operation.(head)
    do_map(tail, operation, accum ++ [transformed_head])
  end
end 

simple_list = [1,2,3]
add_one = &(&1 + 1)

IO.inspect(PunchCafe.Enum.map(simple_list, add_one))