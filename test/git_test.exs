defmodule Issues.GitTest do
  use ExUnit.Case
  doctest Issues.Git

  import Issues.Git, only: [ process: 1]

  test "process returns args" do
    assert process({"elixir-lang", "elixir", 4}) == {"elixir-lang", "elixir", 4}
  end
end
