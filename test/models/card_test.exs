defmodule DeckBuilder.CardTest do
  use DeckBuilder.ModelCase
  alias DeckBuilder.Card

  @valid_attrs %{api_id: "some content", colors: ["some content"], cost: "some content", formats: %{"thing": "some content"}, image_url: "some content", name: "some content", power: "some content", rules_text: "some content", toughness: "some content", url: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Card.changeset(%Card{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Card.changeset(%Card{}, @invalid_attrs)
    refute changeset.valid?
  end
end
