defmodule WeatherCheckerTest do
  use ExUnit.Case

  test "initial test harness" do
    WeatherChecker.CLI.main(nil)
  end
end
