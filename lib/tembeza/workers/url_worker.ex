defmodule Tembeza.Workers.UrlWorker do
  @moduledoc """
  Used to create a new thread to fetch and parse the data form the url.
  """

  use GenServer
  alias Tembeza.Handlers.UrlHandler
  require Logger

  def start_link do
    GenServer.start_link(__MODULE__, %{}, name: UrlWorker)
  end

  def init(state) do
    {:ok, state}
  end

  #############################################
  ### External
  #############################################

  def fetch(url) do
    GenServer.call(UrlWorker, {:fetch, url})
  end

  #############################################
  ### Internal API
  #############################################

  def handle_info({_pubsub_id, event}, state) do
    Logger.error("Tembeza - Missed handler. Event: #{inspect(event)}.")
    {:noreply, state}
  end

  def handle_call({:fetch, url}, _from, state) do
    reply = UrlHandler.fetch(url)
    {:reply, reply, state}
  end

end
