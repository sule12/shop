defmodule ShopWeb.ClothLive.Index do
  use ShopWeb, :live_view

  alias Shop.Collection
  alias Shop.Collection.Cloth

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :clothes, Collection.list_clothes())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Cloth")
    |> assign(:cloth, Collection.get_cloth!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Cloth")
    |> assign(:cloth, %Cloth{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Clothes")
    |> assign(:cloth, nil)
  end

  @impl true
  def handle_info({ShopWeb.ClothLive.FormComponent, {:saved, cloth}}, socket) do
    {:noreply, stream_insert(socket, :clothes, cloth)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    cloth = Collection.get_cloth!(id)
    {:ok, _} = Collection.delete_cloth(cloth)

    {:noreply, stream_delete(socket, :clothes, cloth)}
  end
end
