defmodule DeckBuilder.Card do
  use DeckBuilder.Web, :model

  schema "cards" do
    field :name, :string
    field :api_id, :string
    field :url, :string
    field :image_url, :string
    field :cost, :string
    field :power, :string
    field :toughness, :string
    field :colors, {:array, :string}
    field :rules_text, :string
    field :formats, :map
    field :types, {:array, :string}

    timestamps
  end

  @required_fields ~w(name api_id url image_url cost colors rules_text types)
  @optional_fields ~w(power toughness)

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
