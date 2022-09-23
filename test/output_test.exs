defmodule OutputTest do
  use ExUnit.Case
  doctest Issues.Output


  test "pad string" do
    assert Issues.Output.pad("abc", 5) == "abc  "
  end
end
