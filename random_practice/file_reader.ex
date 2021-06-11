defmodule ReadMe do
    def read_file() do
        file = File.open!("file_to_read")
        IO.inspect(IO.read(file, :line))
        IO.inspect(IO.read(file, :line))
    end
end

ReadMe.read_file()