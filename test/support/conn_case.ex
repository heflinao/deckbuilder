defmodule DeckBuilder.ConnCase do
  @moduledoc """
  This module defines the test case to be used by
  tests that require setting up a connection.

  Such tests rely on `Phoenix.ConnTest` and also
  imports other functionality to make it easier
  to build and query models.

  Finally, if the test case interacts with the database,
  it cannot be async. For this reason, every test runs
  inside a transaction which is reset at the beginning
  of the test unless the test case is marked as async.
  """

  use ExUnit.CaseTemplate

  using do
    quote do
      # Import conveniences for testing with connections
      use Phoenix.ConnTest
      use Hound.Helpers

      alias DeckBuilder.Repo
      import Ecto
      import Ecto.Changeset
      import Ecto.Query, only: [from: 1, from: 2]

      import DeckBuilder.Router.Helpers
      hound_session


      # The default endpoint for testing
      @endpoint DeckBuilder.Endpoint
    end
  end

  setup tags do
    unless tags[:async] do
      Ecto.Adapters.SQL.restart_test_transaction(DeckBuilder.Repo, [])

      on_exit fn ->
        Ecto.Adapters.SQL.rollback_test_transaction(DeckBuilder.Repo)
      end
    end

    {:ok, conn: Phoenix.ConnTest.conn()}
  end
end
