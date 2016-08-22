defmodule DeckBuilder.CardSearcher do
  alias DeckBuilder.Repo
  alias DeckBuilder.Card
  import Ecto.Query

  def search(query) do
    query |> Repo.all
  end
end
