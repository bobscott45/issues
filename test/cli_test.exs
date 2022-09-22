defmodule CLITest do
  use ExUnit.Case
  doctest Issues.CLI

  import Issues.CLI, only: [ parse_args: 1]

  test ":help returned for -h and --help options" do
    assert parse_args(["-h", "anything"]) == :help
  end
end
