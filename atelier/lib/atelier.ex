defmodule Atelier do
  @moduledoc """
  Documentation for `Atelier`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Atelier.hello()
      :world

  """
  def hello do
    :world
  end

  def open_json_file(path) do
    with {:ok, encoded} <- file_read(path),
         {:ok, decoded} <- json_decode(encoded) do
      {:ok, decoded}
    end
  end

  defp json_decode(encoded) do
    case Jason.decode(encoded) do
      {:ok, decoded} -> {:ok, decoded}
      {:error, _} -> {:error, :badfile}
    end
  end

  defp file_read(path) do
    case File.read(path) do
      {:ok, contents} -> {:ok, contents}
      {:error, _} -> {:error, :badfile}
    end
  end
end
