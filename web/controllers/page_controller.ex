defmodule DeckBuilder.PageController do
  use DeckBuilder.Web, :controller
  alias DeckBuilder.Card
  alias DeckBuilder.Paginator
  import Ecto.Query

  def index(conn, params) do
    paginator = Card |> order_by(asc: :name) |> Paginator.new(params)

    render conn, "index.html",
    cards: paginator.records,
    page: paginator.page,
    per_page: paginator.per_page,
    total_pages: paginator.total_pages
  end
end
