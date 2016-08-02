defmodule DeckBuilder.PageController do
  use DeckBuilder.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
