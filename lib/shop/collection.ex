defmodule Shop.Collection do
  @moduledoc """
  The Collection context.
  """

  import Ecto.Query, warn: false
  alias Shop.Repo

  alias Shop.Collection.Cloth

  @doc """
  Returns the list of clothes.

  ## Examples

      iex> list_clothes()
      [%Cloth{}, ...]

  """
  def list_clothes do
    Repo.all(Cloth)
  end

  @doc """
  Gets a single cloth.

  Raises `Ecto.NoResultsError` if the Cloth does not exist.

  ## Examples

      iex> get_cloth!(123)
      %Cloth{}

      iex> get_cloth!(456)
      ** (Ecto.NoResultsError)

  """
  def get_cloth!(id), do: Repo.get!(Cloth, id)

  @doc """
  Creates a cloth.

  ## Examples

      iex> create_cloth(%{field: value})
      {:ok, %Cloth{}}

      iex> create_cloth(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_cloth(attrs \\ %{}) do
    %Cloth{}
    |> Cloth.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a cloth.

  ## Examples

      iex> update_cloth(cloth, %{field: new_value})
      {:ok, %Cloth{}}

      iex> update_cloth(cloth, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_cloth(%Cloth{} = cloth, attrs) do
    cloth
    |> Cloth.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a cloth.

  ## Examples

      iex> delete_cloth(cloth)
      {:ok, %Cloth{}}

      iex> delete_cloth(cloth)
      {:error, %Ecto.Changeset{}}

  """
  def delete_cloth(%Cloth{} = cloth) do
    Repo.delete(cloth)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking cloth changes.

  ## Examples

      iex> change_cloth(cloth)
      %Ecto.Changeset{data: %Cloth{}}

  """
  def change_cloth(%Cloth{} = cloth, attrs \\ %{}) do
    Cloth.changeset(cloth, attrs)
  end
end
