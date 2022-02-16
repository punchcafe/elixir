defmodule StackGenServerTest do
  use ExUnit.Case
  doctest StackGenServer

  test "greets the world" do
    assert StackGenServer.hello() == :world
  end
end
