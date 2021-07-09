defmodule WeatherChecker.CLI do
    def main(argv) do
        WeatherChecker.ExternalData.get_weather_information()
        |> to_string()
        |> IO.puts()
    end
end