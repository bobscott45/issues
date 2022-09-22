defmodule OutputTest do
  use ExUnit.Case
  doctest Issues.Output

  import Issues.Output, only: [pad: 2]

  test "pad string" do
    assert Issues.Output.pad("abc", 5) == "abc  "
  end
end
