defmodule Atelier.Repo.Migrations.CreateItems do
  use Ecto.Migration

  def change do
    create table(:items) do
      add :name, :string, null: false
      add :description, :text
      add :item_type_id, references(:item_types, on_delete: :delete_all), null: false
    end

    create unique_index(:items, [:name])
  end
end
