defmodule VanillaWeb.IntegrationCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      use Hound.Helpers # See https://github.com/HashNuke/hound for usage info
      import Plug.Conn
      import Phoenix.ConnTest
      import Vanilla.EmailHelpers
      import VanillaWeb.IntegrationHelpers
      alias VanillaWeb.Router.Helpers, as: Routes
      alias Vanilla.Factory

      @endpoint VanillaWeb.Endpoint
    end
  end

  setup tags do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Vanilla.Repo)

    unless tags[:async] do
      Ecto.Adapters.SQL.Sandbox.mode(Vanilla.Repo, {:shared, self()})
    end

    # Vanilla.DataHelpers.empty_database()
    ensure_driver_running()
    System.put_env("SUPERADMIN_EMAILS", "superadmin@example.com")
    {:ok, conn: Phoenix.ConnTest.build_conn()}
  end

  def ensure_driver_running do
    {processes, _code} = System.cmd("ps", [])

    unless processes =~ "chromedriver" do
      raise "Integration tests require ChromeDriver. Run `chromedriver` first."
    end
  end
end
