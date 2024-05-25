defmodule Atelier.Repo.Migrations.CreateItemTypes do
  use Ecto.Migration

  def change do
    create table(:item_types) do
      add :name, :string, null: false
    end
  end
end
