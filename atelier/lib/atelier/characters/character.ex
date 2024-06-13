defmodule Atelier.Characters.Character do
  use Ecto.Schema
  # import Ecto.Changeset

  schema "characters" do
    field :name, :string
    field :cv, :string
    field :age, :integer
    field :height, :integer
    field :blood_type, :string
    field :description, :string
  end
end
