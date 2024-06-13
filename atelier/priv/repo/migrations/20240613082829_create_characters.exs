defmodule Atelier.Repo.Migrations.CreateCharacters do
  use Ecto.Migration

  def change do
    create table(:characters) do
      add :name, :string, null: false
      add :cv, :string, null: false
      add :age, :integer, null: false
      add :height, :integer, null: false
      add :blood_type, :string, null: false
      add :description, :string, null: false
    end

  end
end
