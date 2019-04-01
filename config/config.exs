# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

config :sing_for_needs, SingForNeeds.Repo,
  database: "sing_for_needs_repo",
  username: System.get_env("POSTGRES_USERNAME") || "postgres",
  password: System.get_env("POSTGRES_PASSWORD") || "postgres",
  hostname: "localhost"

# Configures the endpoint
config :sing_for_needs, SingForNeedsWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "RnmcWcNx67dA+IAkmQEmQAa5BzRW3LByzxM/48XD6u0uPH8NQKXcNB/VQiJ3QOws",
  render_errors: [view: SingForNeedsWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: SingForNeeds.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
config :phoenix, :json_library, Jason

# add ecto repositories configuration
config :sing_for_needs,
  ecto_repos: [SingForNeeds.Repo]
