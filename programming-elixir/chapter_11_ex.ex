defmodule StringsAndCharlists do
    @whitespace_char Enum.at(' ', 0)
    @supported_operations '+-*/'
    def printable?([char]) when is_integer(char) do
        char < ?~ and char > @whitespace_char
    end

    def anagram?(charlist_1, charlist_2) do
        Enum.frequencies(charlist_1) == Enum.frequencies(charlist_2)
    end

    def evaluate(charlist_exp) do
        parse_charlist_into_operands(charlist_exp)
        |> execute_expression()
    end

    defp execute_expression(%{lhs: lhs, rhs: rhs, operation: ?+}), do: lhs + rhs
    defp execute_expression(%{lhs: lhs, rhs: rhs, operation: ?-}), do: lhs - rhs
    defp execute_expression(%{lhs: lhs, rhs: rhs, operation: ?*}), do: lhs * rhs
    defp execute_expression(%{lhs: lhs, rhs: rhs, operation: ?/}), do: lhs / rhs
    

    defp parse_charlist_into_operands(charlist_expression) do
        extract_lhs(charlist_expression, [])
        |> extract_operand()
        |> extract_rhs()
    end

    defp extract_operand(%{lhs: _, remainder: [operation | remainder]} = input) when operation in @supported_operations do
      %{ input | operation: operation, remainder: remainder }
    end

    defp extract_lhs([charlist_head | charlist_tail], acc) when charlist_head == @whitespace_char do
        value = Enum.reverse(acc)
        |> charlist_to_int()
        %{lhs: value, remainder: charlist_tail, operation: nil, rhs: nil}
    end
    defp extract_lhs([charlist_head | charlist_tail], acc), do: extract_lhs(charlist_tail, [charlist_head | acc])

    defp charlist_to_int(charlist) do
        to_string(charlist)
        |> Integer.parse()
        |> elem(0)
    end

    defp extract_rhs(%{lhs: _, operation: _,remainder: [ @whitespace_char | remainder]} = input) do
      %{ input | rhs: charlist_to_int(remainder), remainder: []}
    end
end

IO.inspect(StringsAndCharlists.evaluate('1 + 2'))
IO.inspect(StringsAndCharlists.evaluate('5 - 1'))
IO.inspect(StringsAndCharlists.evaluate('1 * 2'))
IO.inspect(StringsAndCharlists.evaluate('5 / 5'))