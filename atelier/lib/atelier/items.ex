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

  def harvest() do
    items = get_items_at_random()
    %{data: for(item <- items, do: data(item))}
  end

  defp get_items_at_random() do
    query = from i in Item,
      order_by: fragment("RANDOM()"),
      limit: ^random_quantity(3, 10),
      preload: [:categories]
    Repo.all(query)
  end

  defp data(%Item{} = item) do
    %{
      name: item.name,
      description: item.description,
      categories: for(category <- item.categories, do: "(#{category.name})"),
      quality: random_qualitiy(20, 85)
    }
  end

  defp random_qualitiy(min, max), do: Enum.random(min..max)
  defp random_quantity(min, max), do: Enum.random(min..max)
end
