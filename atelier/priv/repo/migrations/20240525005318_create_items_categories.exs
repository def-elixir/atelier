defmodule Atelier.Repo.Migrations.CreateItemsCategories do
  use Ecto.Migration

  def change do
    create table(:items_categories) do
      add :item_id, references(:items)
      add :category_id, references(:categories)
    end

    create unique_index(:items_categories, [:item_id, :category_id])
  end
end
