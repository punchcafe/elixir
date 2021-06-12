defmodule Primes do
    def get_primes_from_two_to(n) do
        number_list = span(2, n)
        Enum.filter(number_list, fn element -> element_not_in_list(element, all_non_primes(number_list)) end)
    end

    defp element_not_in_list(element, [_head|_tail] = list) do
        element not in list
    end

    defp all_non_primes(numbers) do
        list_of_nums = for n <- numbers, j <- numbers, j < n, rem(n, j) == 0, do: n
        Enum.uniq(list_of_nums)
    end

    defp span(from, to) when from > to, do: []
    defp span(same_val, same_val), do: [same_val]
    defp span(from, to) do
        [from | span(from + 1, to)]
    end
end

IO.inspect(Primes.get_primes_from_two_to(10))