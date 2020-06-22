defmodule TembezaWeb.Router do
  use TembezaWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", TembezaWeb do
    pipe_through :browser

    get "/", PageController, :index
  end

  scope "/api", TembezaWeb do
    pipe_through :api

    get "/fetch", UrlController, :fetch
  end
end
