defmodule Atelier.Items.Category do
  use Ecto.Schema
  # import Ecto.Changeset

  schema "categories" do
    field :name, :string
    many_to_many :items, Atelier.Items.Item, join_through: "items_categories"
  end
end
