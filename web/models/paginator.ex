defmodule DeckBuilder.Paginator do
  alias DeckBuilder.Repo
  alias DeckBuilder.Card
  import Ecto.Query
  defstruct [:page, :per_page, :records, :total_pages]
  require IEx

  def new(query, params) do
    page = page(params)
    per_page = per_page(params)
    records = records(query, page, per_page)

    %DeckBuilder.Paginator{
      records: records,
      page: page,
      per_page: per_page,
      total_pages: total_pages(per_page)
    }
  end

  defp records(query, page, per_page) do
    offset = (page - 1) * per_page

    query
    |> Ecto.Query.limit([_], ^per_page)
    |> Ecto.Query.offset([_], ^offset)
    |> Repo.all
  end

  defp total_pages(per_page) do
    count = Repo.one(from c in Card, select: count(c.id))

    (count / per_page)
    |> Float.ceil
    |> to_integer
  end

  defp page(params) do
    params
    |> Map.get("page", 1)
    |> to_integer
  end

  defp per_page(params) do
    params
    |> Map.get("per_page", 26)
    |> to_integer
  end

  defp to_integer(value) do
    cond do
    is_integer(value) ->
      value
    is_bitstring(value) ->
      String.to_integer(value)
    is_float(value) ->
      round(value)
    end
  end
end
