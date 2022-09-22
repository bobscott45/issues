defmodule Issues.GitHub do
  @moduledoc false

  @user_agent [{"User-agent", "Elixir bob@rwscott.co.uk}"}]
  @github_url Application.get_env(:issues, :github_url)

  def process(:help), do: IO.puts "usage: issues <user> <project> [ count | 4 ]"
  def process({user, project, count }) do
    fetch(user, project)
    |> parse_json
    |> Enum.sort_by(&(&1["created_at"]), :desc)
    |> Enum.take(count)
    |> format_output
  end

  def fetch(user, project) do
    url(user, project)
    |> HTTPoison.get(@user_agent)
    |> handle_http_response
    |> case do
         {:ok, body} -> body
         {_, body} -> handle_error(body)
       end
  end

  defp handle_http_response({:ok, %{status_code: 200, body: body}}), do: {:ok, body}
  defp handle_http_response({_, %{status_code: _, body: body }}), do: {:error, body}

  defp parse_json(body) do
    Poison.Parser.parse!(body)
  end

  defp format_output(data) do
    Enum.map(data, fn(a) -> { a["number"], a["created_at"], a["title"] } end)
  end

  defp handle_error(body) do
    IO.puts "Error fetching from github: #{body}"
    System.halt(2)
  end

  defp url(user, project) do
    "#{@github_url}/repos/#{user}/#{project}/issues"
  end
end
