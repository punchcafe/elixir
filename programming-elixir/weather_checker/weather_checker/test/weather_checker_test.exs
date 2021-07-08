defmodule WeatherCheckerTest do
  use ExUnit.Case
  doctest WeatherChecker

  test "greets the world" do
    assert WeatherChecker.hello() == :world
  end
end
