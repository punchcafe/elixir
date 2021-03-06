defmodule PunchCafe.Stream do
    defstruct collection: [], operation: &PunchCafe.Stream.identity/1 # iterator: nil -> use iterator instead of a collection base, allowing for protocols

    def identity(self) do
        self
    end

    def of(collection) do
        %PunchCafe.Stream{collection: collection}
    end

    def map(%PunchCafe.Stream{} = stream, operation) do
        %PunchCafe.Stream{ stream | operation: fn obj -> operation.(stream.operation.(obj)) end }
    end

    def filter(%PunchCafe.Stream{} = stream, predicate) do
        %PunchCafe.Stream{ stream | operation: fn obj -> allow_to_pass_if_true(stream.operation.(obj), predicate) end }
    end

    defp allow_to_pass_if_true(value, predicate) do
        if predicate.(value), do: value, else: :empty
    end

    def collect_to_list(%PunchCafe.Stream{} = stream) do
        map_and_drop_empty(stream.collection, stream.operation)
    end

    def collect_to_map(%PunchCafe.Stream{} = stream, key_generator) do
        insert_into_map(map_and_drop_empty(stream.collection, stream.operation), key_generator)
    end

    defp insert_into_map([head|tail], key_generator) do
        Map.put_new(insert_into_map(tail, key_generator), key_generator.(head), head)
    end
    defp insert_into_map([], _key_generator), do: %{}

    defp map_and_drop_empty([], _function), do: [] 
    defp map_and_drop_empty([head|tail], function) do
        result = function.(head)
        if result == :empty do
            map_and_drop_empty(tail, function)
        else
            [result | map_and_drop_empty(tail, function)]
        end
    end
end

result = PunchCafe.Stream.of([1, 2])
|> PunchCafe.Stream.map(&(&1 + 1))
|> PunchCafe.Stream.map(&(&1 * 3))
|> PunchCafe.Stream.filter(&(rem(&1,2)==0))
|> PunchCafe.Stream.collect_to_list()

result2 = PunchCafe.Stream.of([1, 2])
|> PunchCafe.Stream.map(&(&1 + 1))
|> PunchCafe.Stream.collect_to_map(&Integer.to_string/1)

IO.inspect result
IO.inspect result2