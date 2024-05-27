defmodule Atelier.Repo.Migrations.CreateItemsCategories do
  use Ecto.Migration

  def change do
    create table(:items_categories, primary_key: false) do
      add :item_id, references(:items, on_delete: :delete_all)
      add :category_id, references(:categories, on_delete: :delete_all)
    end

    create unique_index(:items_categories, [:item_id, :category_id])
  end
end
