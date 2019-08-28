# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :adopt_a_family,
  ecto_repos: [AdoptAFamily.Repo]

# Configures the endpoint
config :adopt_a_family, AdoptAFamilyWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "uH7QlJldXh5vX9o8B07MLPTFA5j+YnZkm/U+u/W4hjsuZN74a+dhiNQBUhnNtU/i",
  render_errors: [view: AdoptAFamilyWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: AdoptAFamily.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"

# Configure your database
config :adopt_a_family, AdoptAFamily.Repo,
  username: "admin", # TODO: Update me
  password: "admin", # TODO: Update me
  database: System.get_env("DB_NAME"),
  hostname: "postgres",
  pool_size: 10
