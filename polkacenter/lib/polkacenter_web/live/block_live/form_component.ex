defmodule PolkacenterWeb.BlockLive.FormComponent do
  use PolkacenterWeb, :live_component

  alias Polkacenter.Polkadex

  @impl true
  def update(%{block: block} = assigns, socket) do
    changeset = Polkadex.change_block(block)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"block" => block_params}, socket) do
    changeset =
      socket.assigns.block
      |> Polkadex.change_block(block_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"block" => block_params}, socket) do
    save_block(socket, socket.assigns.action, block_params)
  end

  defp save_block(socket, :edit, block_params) do
    case Polkadex.update_block(socket.assigns.block, block_params) do
      {:ok, _block} ->
        {:noreply,
         socket
         |> put_flash(:info, "Block updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_block(socket, :new, block_params) do
    case Polkadex.create_block(block_params) do
      {:ok, _block} ->
        {:noreply,
         socket
         |> put_flash(:info, "Block created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
