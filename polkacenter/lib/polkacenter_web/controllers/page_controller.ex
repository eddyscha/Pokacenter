defmodule PolkacenterWeb.PageController do
  use PolkacenterWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
