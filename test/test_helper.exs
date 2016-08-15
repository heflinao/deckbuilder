Mix.Task.run "ecto.create", ~w(-r DeckBuilder.Repo --quiet)
Mix.Task.run "ecto.migrate", ~w(-r DeckBuilder.Repo --quiet)
ExUnit.start

Ecto.Adapters.SQL.Sandbox.mode(DeckBuilder.Repo, :manual)
