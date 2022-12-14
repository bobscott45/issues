defmodule Issues.CLITest do
  use ExUnit.Case
  doctest Issues.CLI

  import Issues.CLI, only: [ parse_args: 1]

  test ":help returned for -h and --help options" do
    assert parse_args(["-h", "anything"]) == :help
    assert parse_args(["--help", "anything"]) == :help
  end

  test "three values returned if three given" do
    assert parse_args(["user", "project", 99]) == {"user", "project", 99}
  end

  test "string count converted to int" do
    assert parse_args(["user", "project", "22"]) == {"user", "project", 22}
  end

  test "invalid count" do
    assert parse_args(["user", "project", "invalid number"]) == :help
  end

  test "count defaults to config value if two values given" do
    assert parse_args(["user", "project"]) == {"user", "project", Application.get_env(:issues, :default_count)}
  end
end
