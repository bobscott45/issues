defmodule Issues.CLI do
  @moduledoc """
  Entry point and command line parsing
  """
  @default_count Application.get_env(:issues, :default_count)

  def main(argv) do
    argv
    |> parse_args
    |> Issues.GitHub.process
    |> Issues.Output.print
  end


  @doc """
  argv - github  username, project name and option number of entries or -h or --help

  Returns `{user, project, count}` or `:help`

  """
  def parse_args(argv) do
    OptionParser.parse(argv, switches: [ help: :boolean], aliases: [h: :help ])
    |> validate_args
    |> format_args
  end

  defp validate_args({ [], [_, _]=args, [] }), do: args
  defp validate_args({ [], [_,_,count] = args, [] }) when is_integer(count), do: args
  defp validate_args({ [], [_,_,count] = args, [] }) do
    case Integer.parse(count) do
      {_, _} -> args
      _ -> false
    end
  end
  defp validate_args(_), do: false


  defp format_args([ user, project, count]) when is_integer(count), do: { user, project, count }
  defp format_args([ user, project, count ]) when is_binary(count), do: { user, project, String.to_integer(count)}
  defp format_args([ user, project ]), do: { user, project, @default_count }
  defp format_args(_), do: :help

end
