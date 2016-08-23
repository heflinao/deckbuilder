defmodule DeckBuilder.FilteringTest do
  use DeckBuilder.ConnCase
  use Hound.Helpers
  alias DeckBuilder.Card
  require IEx

  hound_session
  
  setup do
    Repo.insert!(Card.changeset(%Card{}, %{
      api_id: "admonition-angel",
      colors: ["white"],
      cost: "{3}{W}{W}{W}",
      image_url: "https://image.deckbrew.com/mtg/multiverseid/197160.jpg",
      name: "Admonition Angel",
      power: "6",
      rules_text: "Flying\nLandfall — Whenever a land enters the battlefield under your control, you may exile target nonland permanent other than Admonition Angel.\nWhen Admonition Angel leaves the battlefield, return all cards exiled with it to the battlefield under their owners' control.",
      toughness: "6",
      url: "https://api.deckbrew.com/mtg/cards/admonition-angel",
      types: ["instant"]
    }))

    Repo.insert!(Card.changeset(%Card{}, %{
      api_id: "ad-nauseam",
      colors: ["white"],
      cost: "{3}{W}{W}{W}",
      image_url: "https://image.deckbrew.com/mtg/multiverseid/197160.jpg",
      name: "Ad Nauseam",
      power: "6",
      rules_text: "Flying\nLandfall — Whenever a land enters the battlefield under your control, you may exile target nonland permanent other than Admonition Angel.\nWhen Admonition Angel leaves the battlefield, return all cards exiled with it to the battlefield under their owners' control.",
      toughness: "6",
      url: "https://api.deckbrew.com/mtg/cards/admonition-angel",
      types: ["creature"]
    }))

    creature = Repo.get_by(Card, api_id: "ad-nauseam")
    instant = Repo.get_by(Card, api_id: "admonition-angel")

    navigate_to "/"
    {:ok, creature: creature, instant: instant}
  end

  test "filter by creatures", %{creature: creature, instant: instant} do
    find_element(:css, "#type_filter option[value='creature']")
    |> click

    find_element(:css, "#type_filter_submit")
    |> click

    assert length(find_all_elements(:class, "card")) == 1
    assert find_element(:class, "card-#{creature.id}")
  end
end
