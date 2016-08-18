defmodule DeckBuilder.Repo.Migrations.AddTypesToCard do
  use Ecto.Migration

  def change do
    alter table(:cards) do
      add :types, {:array, :string}
    end
  end
end
