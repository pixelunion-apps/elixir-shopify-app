defmodule ShopifyAppWeb.ShopAdmin.PolarisComponents do
  @moduledoc """
  Polaris Components

  These components are an implementation of the Shopify Polaris design system.

  Style attributes are taken from Polaris Tokens. https://polaris.shopify.com/tokens/color

  See https://polaris.shopify.com/components
  """

  use Phoenix.Component

  defdelegate spinner(assigns), to: ShopifyAppWeb.ShopAdmin.PolarisComponents.Spinner
  defdelegate box(assigns), to: ShopifyAppWeb.ShopAdmin.PolarisComponents.Box
  defdelegate text(assigns), to: ShopifyAppWeb.ShopAdmin.PolarisComponents.Text
  defdelegate card(assigns), to: ShopifyAppWeb.ShopAdmin.PolarisComponents.Card
end
