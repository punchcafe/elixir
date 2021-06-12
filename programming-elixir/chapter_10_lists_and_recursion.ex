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

defmodule Taxables do
    def apply_tax([ id: _id, ship_to: ship_to, net_amount: net_amount ] = order_item, tax_rates ) do
      rate = Keyword.get(tax_rates, ship_to, 0)
      Keyword.put( order_item, :net_amount, net_amount + rate*net_amount)
    end
    def apply_taxes_to_order(orders, tax) do
        Enum.map(orders, fn order -> apply_tax(order, tax) end)
    end
end

IO.inspect(Primes.get_primes_from_two_to(10))

tax_rates = [NC: 0.075, TX: 0.08]
orders = [
    [id: 123, ship_to: :NC, net_amount: 100.00],
    [id: 124, ship_to: :OK, net_amount: 35.50],
    [id: 125, ship_to: :TX, net_amount: 24.00],
    [id: 126, ship_to: :TX, net_amount: 44.80],
    [id: 127, ship_to: :NC, net_amount: 25.00],
    [id: 128, ship_to: :MA, net_amount: 10.00],
    [id: 129, ship_to: :CA, net_amount: 102.00],
    [id: 130, ship_to: :NC, net_amount: 50.00]
]

IO.inspect(Taxables.apply_taxes_to_order(orders, tax_rates))