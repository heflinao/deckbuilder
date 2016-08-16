ExUnit.start

Mix.Task.run "ecto.create", ~w(-r DeckBuilder.Repo --quiet)
Mix.Task.run "ecto.migrate", ~w(-r DeckBuilder.Repo --quiet)
Ecto.Adapters.SQL.begin_test_transaction(DeckBuilder.Repo)
Application.ensure_all_started(:hound)
ExUnit.start
