defmodule PunchCafe.Span do
    def span(from, to) when from > to, do: []
    def span(same_val, same_val), do: [same_val]
    def span(from, to) do
        [from | span(from + 1, to)]
    end
end

alias PunchCafe.Span
IO.inspect(Span.span(1,10))