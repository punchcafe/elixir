defmodule MakeMacros do
    defmacro increment_a(var_ast) do
        quote do
            #original = a
            #a = original + 1

            unquote {:=, [], [var_ast, {:+, [], [var_ast, 1]}]}
        end
    end

    def method do
        a = 0;
        IO.inspect(quote do: a)
        increment_a(a)
        increment_a(a)
        IO.inspect(a)
        #increment_a()
    end
end
IO.inspect(quote do: (a = "hi"))
MakeMacros.method()