defmodule ShopifyAppWeb.ShopAdminLive.Settings do
  use ShopifyAppWeb, :shop_admin_live_view

  @impl true
  def mount(_params, _session, socket) do
    connected?(socket) |> dbg
    {:ok, socket}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :settings, _params) do
    assign(socket, :page_title, "Settings")
  end

  defp apply_action(socket, :more_settings, _params) do
    assign(socket, :page_title, "More Settings")
  end
end
