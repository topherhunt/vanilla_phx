defmodule VanillaWeb.RejectSpamUrls do
  import Phoenix.Controller
  import Plug.Conn

  @behaviour Plug

  def init(opts), do: opts

  def call(conn, _opts) do
    path = conn.request_path
    method = conn.method

    if path =~ ~r/\.php$/ ||
       path =~ ~r/\.env$/ ||
       path =~ ~r/\.git$/ ||
       path =~ "phpunit" ||
       path =~ "wp-includes" ||
       path == "/" && method == "POST" do
      conn
      |> put_status(404)
      |> text("Forbidden")
      |> halt()
    else
      conn
    end
  end
end
