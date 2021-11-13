defmodule Vanilla.MixProject do
  use Mix.Project

  def project do
    [
      app: :vanilla,
      version: "0.1.0",
      elixir: "1.8.1",
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: [:phoenix, :gettext] ++ Mix.compilers(),
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps()
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {Vanilla.Application, []},
      extra_applications: [:logger, :runtime_tools, :os_mon]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      # Core
      {:cowboy, "2.7.0"}, # 2.8.0 requires OTP 22+
      {:ecto_sql, "~> 3.1"},
      {:gettext, "~> 0.11"},
      {:jason, "~> 1.0"},
      {:phoenix, "~> 1.5"},
      {:phoenix_ecto, "~> 4.0"},
      {:phoenix_html, "~> 2.11"},
      {:phoenix_live_view, "~> 0.14.2"},
      {:phoenix_live_dashboard, "~> 0.2"},
      {:phoenix_pubsub, "~> 2.0"},
      {:plug_cowboy, "~> 2.3"},
      {:postgrex, "~> 0.15"},
      {:telemetry_poller, "~> 0.4"},
      {:telemetry_metrics, "~> 0.4"},

      # Other
      {:argon2_elixir, "~> 2.3"},
      {:bamboo, "~> 1.3"},
      {:bamboo_smtp, "~> 3.0"},
      {:floki, "~> 0.24"},
      {:nanoid, "~> 2.0"},
      {:rollbax, "~> 0.11"},
      {:timex, "~> 3.6"},

      # Dev & test
      {:hound, "~> 1.0", only: :test},
      {:phoenix_live_reload, "~> 1.2", only: :dev}
    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to create, migrate and run the seeds file at once:
  #
  #     $ mix ecto.setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    [
      "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      test: ["ecto.create --quiet", "ecto.migrate", "test"]
    ]
  end
end
