defmodule ChapterSix do

    def times(x, 3), do: x * 3

    def sum(0), do: 0
    def sum(x) when x > 0 do
     x + sum(x-1)
    end
end

defmodule RangeFinder do

    def guess(range), do: binary_search(range)

    defp binary_search(range)

    defp binary_search(low..high) when (high - low) == 0 do
        low
    end

    defp binary_search(low..high = range) do
        midpoint = div(high+low, 2)
        IO.gets(:stdio, "Is it #{midpoint}?")
        |> String.trim()
        |> intepret_input(midpoint, range)
        |> binary_search
    end

    defp intepret_input("higher", guess, low..high), do: (guess+1)..high
    defp intepret_input("lower", guess, low..high), do: low..(guess-1)
    defp intepret_input("yes", guess, low..high = range), do: guess..guess
end
IO.puts(ChapterSix.times(5, 3))