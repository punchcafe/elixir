defmodule CLITest do
    use ExUnit.Case
    doctest Chapter13

    import Chapter13.CLI, only: [parse_args: 1]

    test "can get help" do
        assert parse_args(["-h", "anything"]) == :help
        assert parse_args(["--help", "anything"]) == :help
    end

    test "three values returned if three give" do
        assert parse_args(["user", "project", "99"]) == {"user", "project", 99}
    end

    test "count is defaulted to 4 if two args given" do
        assert parse_args(["user", "project"]) == {"user", "project", 4}
    end
end