defmodule Shop.CollectionTest do
  use Shop.DataCase

  alias Shop.Collection

  describe "clothes" do
    alias Shop.Collection.Cloth

    import Shop.CollectionFixtures

    @invalid_attrs %{name: nil, description: nil, unit_price: nil}

    test "list_clothes/0 returns all clothes" do
      cloth = cloth_fixture()
      assert Collection.list_clothes() == [cloth]
    end

    test "get_cloth!/1 returns the cloth with given id" do
      cloth = cloth_fixture()
      assert Collection.get_cloth!(cloth.id) == cloth
    end

    test "create_cloth/1 with valid data creates a cloth" do
      valid_attrs = %{name: "some name", description: "some description", unit_price: 120.5}

      assert {:ok, %Cloth{} = cloth} = Collection.create_cloth(valid_attrs)
      assert cloth.name == "some name"
      assert cloth.description == "some description"
      assert cloth.unit_price == 120.5
    end

    test "create_cloth/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Collection.create_cloth(@invalid_attrs)
    end

    test "update_cloth/2 with valid data updates the cloth" do
      cloth = cloth_fixture()
      update_attrs = %{name: "some updated name", description: "some updated description", unit_price: 456.7}

      assert {:ok, %Cloth{} = cloth} = Collection.update_cloth(cloth, update_attrs)
      assert cloth.name == "some updated name"
      assert cloth.description == "some updated description"
      assert cloth.unit_price == 456.7
    end

    test "update_cloth/2 with invalid data returns error changeset" do
      cloth = cloth_fixture()
      assert {:error, %Ecto.Changeset{}} = Collection.update_cloth(cloth, @invalid_attrs)
      assert cloth == Collection.get_cloth!(cloth.id)
    end

    test "delete_cloth/1 deletes the cloth" do
      cloth = cloth_fixture()
      assert {:ok, %Cloth{}} = Collection.delete_cloth(cloth)
      assert_raise Ecto.NoResultsError, fn -> Collection.get_cloth!(cloth.id) end
    end

    test "change_cloth/1 returns a cloth changeset" do
      cloth = cloth_fixture()
      assert %Ecto.Changeset{} = Collection.change_cloth(cloth)
    end
  end
end
