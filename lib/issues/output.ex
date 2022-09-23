defmodule Issues.Output do
  @moduledoc false

  def print(issues) do
    IO.puts " #    | created_at           | title"
    IO.puts "------+----------------------+------------------------------------------------------"
    for { number, created, title} <- issues do IO.puts "#{ pad(number, 5) } | #{ created } | #{ title }" end
    IO.puts ""
  end

  def pad(val, width) when is_integer(val), do: String.pad_trailing(Integer.to_string(val), width)
  def pad(val, width), do: String.pad_trailing(val, width)

end
