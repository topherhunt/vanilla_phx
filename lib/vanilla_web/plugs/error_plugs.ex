defmodule VanillaWeb.ErrorPlugs do
  # Report each Plug request error to Rollbar.
  # This does NOT auto-report errors in unlinked background jobs, liveviews, etc.
  # See https://hexdocs.pm/rollbax/using-rollbax-in-plug-based-applications.html
  def handle_errors(conn, %{kind: kind, reason: reason, stack: stacktrace}) do
    conn =
      conn
      |> Plug.Conn.fetch_cookies()
      |> Plug.Conn.fetch_query_params()

    user = conn.assigns[:current_user]
    user_string = if user, do: "#{user.id}", else: "(none)"

    params =
      case conn.params do
        %Plug.Conn.Unfetched{aspect: :params} -> "unfetched"
        other -> other
      end

    request_data = %{
      "request" => %{
        "cookies" => conn.req_cookies,
        "url" => "#{conn.scheme}://#{conn.host}:#{conn.port}#{conn.request_path}",
        "user_ip" => List.to_string(:inet.ntoa(conn.remote_ip)),
        "headers" => Enum.into(conn.req_headers, %{}),
        "method" => conn.method,
        "params" => params,
        "user" => user_string
      }
    }

    Rollbax.report(kind, reason, stacktrace, _custom_data = %{}, request_data)
  end
end
