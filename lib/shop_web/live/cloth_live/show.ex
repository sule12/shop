defmodule ShopWeb.ClothLive.Show do
  use ShopWeb, :live_view

  alias Shop.Collection

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:cloth, Collection.get_cloth!(id))}
  end

  defp page_title(:show), do: "Show Cloth"
  defp page_title(:edit), do: "Edit Cloth"
end
