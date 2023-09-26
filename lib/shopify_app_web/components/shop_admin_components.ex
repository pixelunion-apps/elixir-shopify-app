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
end
