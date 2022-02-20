defmodule Stack.Cache do

    use GenServer

    def start_link() do
        GenServer.start_link(__MODULE__, nil, name: __MODULE__)
    end

    @impl GenServer
    def init(_), do: {:ok, nil}

    @impl GenServer
    def handle_cast({:store, new_state}, _state), do: {:no_reply, new_state}

    @impl GenServer
    def handle_call(:retrieve, _caller, state), do: {:reply, state, state}

end