defmodule PunchCafe.Enum do

    def all?([]), do: true
    def all?([head|tail]) do
      if head, do: all?(tail), else: false
    end

    def filter([], _predicate), do: []
    def filter([head|tail], predicate) do
      if predicate.(head), do: [head|filter(tail, predicate)], else: filter(tail, predicate)
    end

    def each([], _fun), do: []
    def each([head|tail] = input, function) do
      function.(head)
      each(tail, function)
      input
    end

    def take(_collection, 0), do: []
    def take([head|tail], amount), do: [head|take(tail, amount - 1)]

    def split(collection, take_until) do
        split_internal(collection, take_until, [])
    end

    defp split_internal([head|tail], 1, accumulator), do: { Enum.reverse([ head | accumulator ]), tail }
    defp split_internal([head|tail], number_to_split_by, accumulator) do
        # todo: look to make use reverse, or purely functional
        split_internal(tail, number_to_split_by - 1, [head | accumulator ] )
    end
end

myguy = ["lol", "anyway", nil]
IO.inspect(PunchCafe.Enum.all?(myguy))
IO.inspect(PunchCafe.Enum.filter(myguy, &(&1)))
PunchCafe.Enum.each(myguy, &(IO.inspect(&1)))
IO.inspect(PunchCafe.Enum.take(myguy, 2))
IO.inspect(PunchCafe.Enum.split(myguy, 2))

