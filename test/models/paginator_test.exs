defmodule DeckBuilder.PaginatorTest do
  use DeckBuilder.ConnCase
  alias DeckBuilder.Paginator
  alias DeckBuilder.Card
  import Ecto.Query

  @valid_attrs %{"page" => "2", "per_page" => "1"}
  @no_attrs %{}

  setup do
    card_changesets = [
      Card.changeset(%Card{}, %{
        api_id: "admonition-angel",
        colors: ["white"],
        cost: "{3}{W}{W}{W}",
        image_url: "https://image.deckbrew.com/mtg/multiverseid/197160.jpg",
        name: "Admonition Angel",
        power: "6",
        rules_text: "Flying\nLandfall — Whenever a land enters the battlefield under your control, you may exile target nonland permanent other than Admonition Angel.\nWhen Admonition Angel leaves the battlefield, return all cards exiled with it to the battlefield under their owners' control.",
        toughness: "6",
        url: "https://api.deckbrew.com/mtg/cards/admonition-angel"
      }),
      Card.changeset(%Card{}, %{
        api_id: "ad-nauseam",
        colors: ["white"],
        cost: "{3}{W}{W}{W}",
        image_url: "https://image.deckbrew.com/mtg/multiverseid/197160.jpg",
        name: "Ad Nauseam",
        power: "6",
        rules_text: "Flying\nLandfall — Whenever a land enters the battlefield under your control, you may exile target nonland permanent other than Admonition Angel.\nWhen Admonition Angel leaves the battlefield, return all cards exiled with it to the battlefield under their owners' control.",
        toughness: "6",
        url: "https://api.deckbrew.com/mtg/cards/admonition-angel"
      })
    ]

    Enum.each(card_changesets, fn(card) ->
      card |> Repo.insert!
    end)
  end

  test "changeset with valid attributes" do
    cards = Card |> order_by(asc: :name) |> Repo.all
    paginator = DeckBuilder.Paginator.new(cards, @valid_attrs)
    card = Repo.get_by(Card, name: "Admonition Angel")

    assert paginator.page == 2
    assert paginator.per_page == 1
    assert paginator.total_pages == 2
    assert paginator.records == [card]
  end

  test "changeset with no attributes" do
    cards = Card |> order_by(asc: :name) |> Repo.all
    paginator = DeckBuilder.Paginator.new(cards, @no_attrs)

    assert paginator.page == 1
    assert paginator.per_page == 26
    assert paginator.total_pages == 1
    assert paginator.records == cards
  end
end
