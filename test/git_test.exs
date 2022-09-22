defmodule Issues.GitTest do
  use ExUnit.Case
  doctest Issues.GitHub

  import Issues.GitHub, only: [ process: 1]

end
