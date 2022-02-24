defmodule Stack.Application do

    def start(_, _) do
        children = [
            %{ id: Stack.Cache, 
                    start: {Stack.Cache, :start_link, []}},
            %{ id: Stack, 
                    start: {Stack.Server, :start_link, []}},
                    ]
        Supervisor.start_link(children, strategy: :rest_for_one)
    end

end