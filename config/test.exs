use Mix.Config

config :sing_for_needs, SingForNeeds.Repo,
  username: System.get_env("POSTGRES_USERNAME") || "postgres",
  password: System.get_env("POSTGRES_PASSWORD") || "postgres",
  database: "sing_for_needs_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
# We don't run a server during test. If one is required,
# you can enable the server option below.
config :sing_for_needs, SingForNeedsWeb.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn
