defmodule DeckBuilder.Repo.Migrations.CreateCard do
  use Ecto.Migration

  def change do
    create table(:cards) do
      add :name, :string
      add :api_id, :string
      add :url, :string
      add :image_url, :string
      add :cost, :string
      add :power, :string
      add :toughness, :string
      add :colors, {:array, :string}
      add :rules_text, :varchar
      add :formats, :map

      timestamps
    end

  end
end
