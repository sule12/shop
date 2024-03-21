defmodule Shop.Collection.Cloth do
  use Ecto.Schema
  import Ecto.Changeset

  schema "clothes" do
    field :name, :string
    field :description, :string
    field :unit_price, :float

    timestamps()
  end

  @doc false
  def changeset(cloth, attrs) do
    cloth
    |> cast(attrs, [:name, :description, :unit_price])
    |> validate_required([:name, :description, :unit_price])
  end
end
