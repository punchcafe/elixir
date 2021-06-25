defmodule Chapter13.CLI do

    @default_count 4

    def run(argv), do: parse_args(argv)

    def parse_args(argv) do
        OptionParser.parse(argv, switches: [help: :boolean], aliases: [h: :help])
        |> elem(1)
        |> get_internal_representation()
    end

    defp get_internal_representation([user, project, count]), do: {user, project, String.to_integer(count)}
    defp get_internal_representation([user, project]), do: {user, project, @default_count}
    defp get_internal_representation(_), do: :help
end