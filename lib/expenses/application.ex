defmodule Expenses.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    build_info = Map.take(System.build_info, [:build, :otp_release])
    Logger.info "#{__MODULE__}: Starting. #{inspect(build_info)}"

    # List all child processes to be supervised
    children = [
      # Start the Ecto repository
      Expenses.Repo,
      # Start the endpoint when the application starts
      ExpensesWeb.Endpoint
      # Starts a worker by calling: Expenses.Worker.start_link(arg)
      # {Expenses.Worker, arg},
    ]

    :ok = :telemetry.detach({Phoenix.Logger, [:phoenix, :socket_connected]})
    :ok = :telemetry.detach({Phoenix.Logger, [:phoenix, :channel_joined]})
    :ok = :telemetry.detach({Phoenix.Logger, [:phoenix, :router_dispatch, :start]})

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Expenses.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    ExpensesWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
