defprotocol StreamIteratorSource do
  def iterator_from(stream_source)
end

defprotocol StreamIterator do
  def get_next(stream_iterator)
end

defmodule ListIterator do
    defstruct source: []
end

defimpl StreamIteratorSource, for: List do
  def iterator_from(collection), do: %ListIterator{source: collection}
end

defimpl StreamIterator, for: ListIterator do
  def get_next(%ListIterator{source: [source_head|source_tail]}) do 
    {source_head, %ListIterator{source: source_tail}}
  end
end

defmodule PunchCafe.Stream do
    defstruct iterator: [%ListIterator{}], operation: nil
    def map(%PunchCafe.Stream{ iterator: _iterator, operation: existing_operation}=stream, operation) do
     %PunchCafe.Stream{stream | operation: fn element -> operation.(existing_operation.(element)) end }
    end
    def next(%PunchCafe.Stream{iterator: iterator} = stream) do
        {next_element, next_iterator} = StreamIterator.get_next(iterator)
        {next_element, %PunchCafe.Stream{ stream | iterator: next_iterator }}
    end
    def from([_head|_tail] = collection) do
        %PunchCafe.Stream{iterator: %ListIterator{source: collection}, operation: &(&1)}
    end
end

PunchCafe.Stream.from([1,2])
|> PunchCafe.Stream.map(&(&1 + 1))
|> PunchCafe.Stream.next()
|> (&(elem(&1, 1))).()
|> PunchCafe.Stream.next()
|> IO.inspect()