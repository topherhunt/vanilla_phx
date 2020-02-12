defmodule ExpensesWeb.PageController do
  use ExpensesWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
