defmodule VanillaWeb.PageController do
  use VanillaWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
