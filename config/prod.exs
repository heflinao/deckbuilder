use Mix.Config

config :deck_builder, DeckBuilder.Endpoint,
  http: [port: {:system, "PORT"}],
  url: [shceme: "https", host: "heflin-deck-builder.herokuapp.com", port: 443],
  force_ssl: [rewrite_on: [:x_forwarded_proto]]

config :logger, level: :info

config :deck_builder, DeckBuilder.Endpoint,
  secret_key_base: System.get_env("SECRET_KEY_BASE")

config :deck_builder, DeckBuilder.Repo,
  adapter: Ecto.Adapters.Postgres,
  url: System.get_env("DATABASE_URL"),
  pool_size: 20

import_config "prod.secret.exs"
