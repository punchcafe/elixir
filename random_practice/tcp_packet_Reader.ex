defmodule TCPReader do
    defstruct source_port: 0, destination_port: 0, sequence_number: 0, ack_number: 0
    

    def parse(bin) do
        TCPReader.parse_ports({bin, %TCPReader{}})
    end 

    def parse_ports({<< source_port::size(16), destination_port::size(16), bin::binary >>, %TCPReader{} = packet}) do
        {bin, %TCPReader{ packet | source_port: source_port, destination_port: destination_port }}
    end
end

bin = 
String.upcase("e05001bb057877fdd35959f750100800e8590000")

IO.inspect(TCPReader.parse(Base.decode16!(bin)))