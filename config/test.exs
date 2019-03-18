use Mix.Config
# configure ecto
use Mix.Config

config :sing_for_needs, SingForNeeds.Repo,
  username: "globalprograms",
  password: "",
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
