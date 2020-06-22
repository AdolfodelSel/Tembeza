defmodule TembezaWeb.PageController do
  use TembezaWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
