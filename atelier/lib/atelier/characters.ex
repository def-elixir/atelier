defmodule Atelier.Characters do
  @moduledoc """
  Documentation for `Atelier.Characters`.
  """

  import Ecto.Query, warn: false
  alias Atelier.Repo
  alias Atelier.Characters.Character

  @doc """
  Returns the list of characters.

  ## Examples

      iex> list_characters()
      [%Character{}, ...]

  """
  def list_characters do
    Repo.all(Character)
  end
end
