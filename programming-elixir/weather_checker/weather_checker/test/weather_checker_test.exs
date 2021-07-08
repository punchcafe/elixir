defmodule WeatherCheckerTest do
  use ExUnit.Case
  doctest WeatherChecker

  test "greets the world" do
    assert WeatherChecker.hello() == :world
  end

  test "initial test harness" do
    IO.inspect(ExternalData.get_weather_information())
  end
end
