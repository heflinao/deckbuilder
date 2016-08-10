defmodule DeckBuilder.CardImporter do
  alias DeckBuilder.Repo
  alias DeckBuilder.Card
  HTTPotion.start

  def import do
    DeckBuilder.Repo.start_link
    
    # there are 164 card pages in the deckbrew api
    Enum.each(1..164, fn(page) ->
      response_for_page(page)
      |> decode_cards
      |> record_all_cards
    end)
  end

  defp response_for_page(page) do
    %{body: body} = HTTPotion.get("https://api.deckbrew.com/mtg/cards?page=" <> to_string(page), hackney: [:insecure])
    body
  end

  defp decode_cards(response) do
    Poison.decode!(response)
  end

  defp record_all_cards(cards) do
    Enum.each(cards, fn(card) ->
      record_card(card)
    end)
  end

  defp record_card(card) do
    unless card["name"] == "_____" do
      editions = List.first(card["editions"])
      params = Map.merge(card, %{"image_url" => editions["image_url"], "api_id" => card["id"], "rules_text" => card["text"]})

      Card.changeset(%Card{}, params)
      |> Repo.insert!
    end
  end
end
