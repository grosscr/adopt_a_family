use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :adopt_a_family, AdoptAFamilyWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

hostname = System.get_env("DB_HOST") || "localhost"
config :adopt_a_family, AdoptAFamily.Repo,
  username: "admin", # TODO: Update me
  password: "admin", # TODO: Update me
  database: "adopt_a_family_test",
  hostname: hostname,
  pool: Ecto.Adapters.SQL.Sandbox
