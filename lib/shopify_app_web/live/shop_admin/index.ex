defmodule ShopifyAppWeb.ShopAdminLive.Index do
  use ShopifyAppWeb, :shop_admin_live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :connected, connected?(socket))}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :live, _params) do
    assign(socket, :page_title, "Home")
  end

  defp apply_action(socket, other, _params) do
    assign(socket, :page_title, "Home - #{other}")
  end

  @impl true
  def handle_event("action", %{"title" => title}, socket) do
    {:noreply,
     socket
     |> assign(:page_title, "Home - " <> title)
     |> put_flash(:info, "A toast message from the flash!")}
  end
end
