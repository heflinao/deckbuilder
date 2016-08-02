use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :deck_builder, DeckBuilder.Endpoint,
  http: [port: 4001],
  server: true

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :deck_builder, DeckBuilder.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "deck_builder_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
