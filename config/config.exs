# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

# Use H.env!/1 to fetch env variables (NOT compatible with best-practice Elixir releases)
defmodule H do
  def env!(key), do: System.get_env(key) || raise("Env var '#{key}' is missing!")
end

# Automatically load sensitive env variables if available (for dev and test)
if File.exists?("config/secrets.exs"), do: import_config("secrets.exs")

config :vanilla, ecto_repos: [Vanilla.Repo]

# Configures the endpoint
config :vanilla, VanillaWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: H.env!("SECRET_KEY_BASE"),
  render_errors: [view: VanillaWeb.ErrorView, accepts: ~w(html json)],
  live_view: [signing_salt: "44VO7xFnVR78VTOFLTeH8BnuFnWdt5H6"],
  pubsub_server: Vanilla.PubSub

# Configures Elixir's Logger
config :logger, :console, format: "$date $time [$level]$metadata $message\n"

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# By default, sent emails are captured in a local process for later inspection.
# Example:
#   Vanilla.AdminEmails.unknown_heats() |> Vanilla.Mailer.deliver_now()
#   Bamboo.SentEmail.all() # => a list having one %Bamboo.Email{} struct
config :vanilla, Vanilla.Mailer, adapter: Bamboo.LocalAdapter

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
