defmodule ShopWeb.ClothLive.FormComponent do
  use ShopWeb, :live_component

  alias Shop.Collection

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage cloth records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="cloth-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:name]} type="text" label="Name" />
        <.input field={@form[:description]} type="text" label="Description" />
        <.input field={@form[:unit_price]} type="number" label="Unit price" step="any" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Cloth</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{cloth: cloth} = assigns, socket) do
    changeset = Collection.change_cloth(cloth)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"cloth" => cloth_params}, socket) do
    changeset =
      socket.assigns.cloth
      |> Collection.change_cloth(cloth_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"cloth" => cloth_params}, socket) do
    save_cloth(socket, socket.assigns.action, cloth_params)
  end

  defp save_cloth(socket, :edit, cloth_params) do
    case Collection.update_cloth(socket.assigns.cloth, cloth_params) do
      {:ok, cloth} ->
        notify_parent({:saved, cloth})

        {:noreply,
         socket
         |> put_flash(:info, "Cloth updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_cloth(socket, :new, cloth_params) do
    case Collection.create_cloth(cloth_params) do
      {:ok, cloth} ->
        notify_parent({:saved, cloth})

        {:noreply,
         socket
         |> put_flash(:info, "Cloth created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
