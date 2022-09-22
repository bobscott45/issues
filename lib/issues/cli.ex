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
    IO.write "argv:"
    IO.inspect argv
    OptionParser.parse(argv, switches: [ help: :boolean], aliases: [h: :help ])
    |> elem(1)
    |> validate_args
    |> format_args
  end

  def validate_args([_, _] = args), do: args
  def validate_args([_,_,count] = args) when is_integer(count), do: args
  def validate_args([_,_,count] = args) do
    case Integer.parse(count) do
      {int_val, _} -> args
      _ -> false
    end
  end
  def validate_args(_), do: false
  def format_args([ user, project, count]) when is_integer(count), do: { user, project, count }
  def format_args([ user, project, count ]) when is_binary(count), do: { user, project, String.to_integer(count)}
  def format_args([ user, project ]), do: { user, project, @default_count }
  def format_args(_), do: :help


end
