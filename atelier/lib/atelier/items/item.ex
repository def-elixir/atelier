defmodule Atelier.Items.Item do
  use Ecto.Schema
  # import Ecto.Changeset

  schema "items" do
    field :name, :string
    field :description, :string
    belongs_to :item_type, Atelier.Items.ItemType
    many_to_many :categories, Atelier.Items.Category, join_through: "items_categories"
  end
end
