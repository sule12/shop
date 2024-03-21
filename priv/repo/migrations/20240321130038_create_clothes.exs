defmodule Shop.Repo.Migrations.CreateClothes do
  use Ecto.Migration

  def change do
    create table(:clothes) do
      add :name, :string
      add :description, :string
      add :unit_price, :float

      timestamps()
    end
  end
end
