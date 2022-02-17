defmodule Stack.Application do

    def start_link(init_number) do
        children = [%{ id: Stack, 
                    start: {Stack, :start_link, [init_number]}}]
        Supervisor.start_link(children, strategy: :one_for_one)
    end

end