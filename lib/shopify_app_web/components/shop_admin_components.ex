defmodule ShopifyAppWeb.ShopAdminComponents do
  @moduledoc """
  Components Specific to ShopAdmin
  """
  use Phoenix.Component
  use ShopifyAppWeb, :verified_routes

  @doc """
  Basic Navigation links
  """
  def navigation_links(assigns) do
    ~H"""
    <div>
      <ul>
        <li><.link patch={~p"/shop_admin/shopify_app/"}>Home</.link></li>
        <li><.link patch={~p"/shop_admin/shopify_app/settings"}>Settings</.link></li>
        <li><.link patch={~p"/shop_admin/shopify_app/more"}>More Settings</.link></li>
      </ul>
    </div>
    """
  end

  @doc """
  Renders Shopify toast notices.

  Uses ShopifyToastHook to integrate with AppBridge
    https://shopify.dev/docs/api/app-bridge-library/reference/toast#example-toast-with-dismiss-callback

  ## Examples

      <.toast kind={:info} flash={@flash} />
      <.toast kind={:error} flash={@flash} />
  """
  attr :id, :string, default: "toast", doc: "the optional id of toast container"
  attr :flash, :map, default: %{}, doc: "the map of flash messages to display"
  attr :kind, :atom, values: [:info, :error], doc: "used for styling and flash lookup"

  def toast(assigns) do
    ~H"""
    <div
      :if={msg = Phoenix.Flash.get(@flash, @kind)}
      id={@id}
      data-message={msg}
      data-kind={@kind}
      phx-hook="ShopifyToastHook"
      hidden
    >
      <%= msg %>
    </div>
    """
  end
end
