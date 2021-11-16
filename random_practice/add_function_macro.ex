defmodule FunctionDefiner do
    defmacro add_speaker do
        quote do: def say_hi(), do: IO.puts("hi!")
    end
end

defmodule ModuleWhichUsesMacro do
    require FunctionDefiner
    FunctionDefiner.add_speaker
end

ModuleWhichUsesMacro.say_hi()