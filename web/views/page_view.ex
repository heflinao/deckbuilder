defmodule DeckBuilder.PageView do
  use DeckBuilder.Web, :view

  def card_rows(params) do
    Enum.chunk(params[:cards], 3)
  end

  def next_page(params) do
    params[:page] + 1
  end

  def prev_page(params) do
    params[:page] - 1
  end

  def first_page(params) do
    params[:page] == 1
  end

  def last_page(params) do
    params[:total_pages] == params[:page]
  end
end
