defmodule TembezaWeb.UrlController do
  use TembezaWeb, :controller
  alias Tembeza.Workers.UrlWorker
  require Logger

  @doc """
  Controller of the option to fetch the requested url.
  """
  def fetch(conn, %{"url" => url}) do
    UrlWorker.fetch(url)
    |> case  do
      {:ok, result} ->
        json(conn, %{status: true, result: result})
      {:error, _error} ->
        json(conn, %{status: false, error: "Error fetching the url"})
    end
  end

  @doc """
  Controller of the option to fetch the requested url. Wrong params.
  """
  def fetch(conn, params) do
    Logger.error("UrlController - Wrong params: #{inspect(params)}")
    put_status(conn, 403)
    |> json(%{status: false, error: "Wrong params"})
  end
end
