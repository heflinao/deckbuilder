defmodule DeckBuilder.PageController do
  use DeckBuilder.Web, :controller
  alias DeckBuilder.Card
  alias DeckBuilder.Paginator
  alias DeckBuilder.CardSearcher
  import Ecto.Query
  require IEx

  def index(conn, params = %{"page" => page, "types" => %{"types" => type}}) do
    records = Card
    |> where([c], ^type in c.types)
    |> order_by(asc: :name)
    |> CardSearcher.search

    paginator = Paginator.new(records, %{"page" => page})
    render_index(conn, paginator, type)
  end

  def index(conn, params = %{"types" => %{"types" => type}}) do
    records = Card
    |> where([c], ^type in c.types)
    |> order_by(asc: :name)
    |> CardSearcher.search

    paginator = Paginator.new(records)
    render_index(conn, paginator, type)
  end

  def index(conn, params) do
    records = Card
    |> order_by(asc: :name)
    |> CardSearcher.search

    paginator = Paginator.new(records, params)
    render_index(conn, paginator, nil)
  end

  defp render_index(conn, paginator, type) do
    render conn, "index.html",
    cards: paginator.records,
    page: paginator.page,
    per_page: paginator.per_page,
    total_pages: paginator.total_pages,
    types: type
  end
end
