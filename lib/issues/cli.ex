defmodule Issues.CLI do
  @moduledoc """
  Entry point and command line parsing
  """
  @default_count 4

  def run(argv) do
    parse_args(argv)
  end

  @doc """
  argv - github  username, project name and option number of entries or -h or --help

  Returns `{user, project, count}` or `:help`

  """
   def parse_args(argv) do
    args = OptionParser.parse(argv, switches: [ help: :boolean], aliases: [h: :help ])

    case args do
      { [help: true], _, _} -> :help
      { _, [ user, project, count ], _ } when is_integer(count) -> { user, project, count }
      { _, [ user, project ], _ } -> { user, project, @default_count }
      _ -> :help
    end
  end
end
