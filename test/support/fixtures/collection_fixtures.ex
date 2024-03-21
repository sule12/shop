defmodule Shop.CollectionFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Shop.Collection` context.
  """

  @doc """
  Generate a cloth.
  """
  def cloth_fixture(attrs \\ %{}) do
    {:ok, cloth} =
      attrs
      |> Enum.into(%{
        description: "some description",
        name: "some name",
        unit_price: 120.5
      })
      |> Shop.Collection.create_cloth()

    cloth
  end
end
