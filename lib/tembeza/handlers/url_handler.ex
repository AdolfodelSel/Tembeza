defmodule Tembeza.Handlers.UrlHandler do
  @moduledoc """
  Used to handle all the operations related with the urls
  """

  require Logger

  @doc """
  To fetch and parse the data from the url to get the assets and the links
  """
  def fetch(url) do
    case HTTPoison.get(url) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        parse_body(body)
      {:ok, %HTTPoison.Response{status_code: 404}} ->
        Logger.error("UrlHandler - Url doesn't found. Url: #{inspect(url)}.")
        {:error, "Url doesn't found"}
      {:error, %HTTPoison.Error{reason: reason}} ->
        Logger.error("UrlHandler - Error fetching the url. Url: #{inspect(url)}. Error: #{inspect(reason)}.")
        {:error, reason}
     end
  end

  defp parse_body(body) do
    case Floki.parse_document(body) do
      {:ok, html} ->
        assets =
          html
          |> Floki.find("img")
          |> Floki.attribute("src")
        links =
          html
          |> Floki.attribute("a", "href")
        {:ok, %{assets: assets, links: links}}
      {:error, error} ->
        Logger.error("UrlHandler - Error parsing the body. Body: #{inspect(body)}. Error: #{inspect(error)}.")
        {:error, error}
    end
  end
end
