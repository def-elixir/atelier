defmodule Atelier.Items do
  @moduledoc """
  Documentation for `Atelier.Items`.
  """

  import Ecto.Query, warn: false
  alias Atelier.Repo
  alias Atelier.Items.Item

  @doc """
  Harvest.

  ## Examples

      iex> Atelier.harvest()
      :world

  """
  def harvest do
    query = from i in Item,
      order_by: fragment("RANDOM()"),
      limit: 10,
      preload: [:categories]
    Repo.all(query)
  end
end
