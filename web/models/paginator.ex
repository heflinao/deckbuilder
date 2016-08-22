defmodule DeckBuilder.Paginator do
  alias DeckBuilder.Repo
  alias DeckBuilder.Card
  import Ecto.Query

  defstruct [:page, :per_page, :records, :total_pages]

  @defaults %{page: 1, per_page: 26}

  def new(records, params \\ @defaults) do
    page = page(params)
    per_page = per_page(params)

    %DeckBuilder.Paginator{
      records: records_per_page(records, page, per_page),
      page: page,
      per_page: per_page,
      total_pages: total_pages(records, per_page)
    }
  end

  defp records_per_page(records, page, per_page) do
    Enum.chunk(records, per_page, per_page, [])
    |> Enum.at(page)
  end

  defp total_pages(records, per_page) do
    count = length(records)

    (count / per_page)
    |> Float.round
    |> to_integer
  end

  defp page(params) do
    params
    |> Map.get("page", @defaults[:page])
    |> to_integer
  end

  defp per_page(params) do
    params
    |> Map.get("per_page", @defaults[:per_page])
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
