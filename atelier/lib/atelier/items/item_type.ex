defmodule Atelier.Items.ItemType do
  use Ecto.Schema
  # import Ecto.Changeset

  schema "item_types" do
    field :name, :string
    has_many :items, Atelier.Items.Item
  end
end
