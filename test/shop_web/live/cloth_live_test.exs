defmodule ShopWeb.ClothLiveTest do
  use ShopWeb.ConnCase

  import Phoenix.LiveViewTest
  import Shop.CollectionFixtures

  @create_attrs %{name: "some name", description: "some description", unit_price: 120.5}
  @update_attrs %{name: "some updated name", description: "some updated description", unit_price: 456.7}
  @invalid_attrs %{name: nil, description: nil, unit_price: nil}

  defp create_cloth(_) do
    cloth = cloth_fixture()
    %{cloth: cloth}
  end

  describe "Index" do
    setup [:create_cloth]

    test "lists all clothes", %{conn: conn, cloth: cloth} do
      {:ok, _index_live, html} = live(conn, ~p"/clothes")

      assert html =~ "Listing Clothes"
      assert html =~ cloth.name
    end

    test "saves new cloth", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/clothes")

      assert index_live |> element("a", "New Cloth") |> render_click() =~
               "New Cloth"

      assert_patch(index_live, ~p"/clothes/new")

      assert index_live
             |> form("#cloth-form", cloth: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#cloth-form", cloth: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/clothes")

      html = render(index_live)
      assert html =~ "Cloth created successfully"
      assert html =~ "some name"
    end

    test "updates cloth in listing", %{conn: conn, cloth: cloth} do
      {:ok, index_live, _html} = live(conn, ~p"/clothes")

      assert index_live |> element("#clothes-#{cloth.id} a", "Edit") |> render_click() =~
               "Edit Cloth"

      assert_patch(index_live, ~p"/clothes/#{cloth}/edit")

      assert index_live
             |> form("#cloth-form", cloth: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#cloth-form", cloth: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/clothes")

      html = render(index_live)
      assert html =~ "Cloth updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes cloth in listing", %{conn: conn, cloth: cloth} do
      {:ok, index_live, _html} = live(conn, ~p"/clothes")

      assert index_live |> element("#clothes-#{cloth.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#clothes-#{cloth.id}")
    end
  end

  describe "Show" do
    setup [:create_cloth]

    test "displays cloth", %{conn: conn, cloth: cloth} do
      {:ok, _show_live, html} = live(conn, ~p"/clothes/#{cloth}")

      assert html =~ "Show Cloth"
      assert html =~ cloth.name
    end

    test "updates cloth within modal", %{conn: conn, cloth: cloth} do
      {:ok, show_live, _html} = live(conn, ~p"/clothes/#{cloth}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Cloth"

      assert_patch(show_live, ~p"/clothes/#{cloth}/show/edit")

      assert show_live
             |> form("#cloth-form", cloth: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#cloth-form", cloth: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/clothes/#{cloth}")

      html = render(show_live)
      assert html =~ "Cloth updated successfully"
      assert html =~ "some updated name"
    end
  end
end
