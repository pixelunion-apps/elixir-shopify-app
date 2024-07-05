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
        <%!--
          # if we want to navigate back to react land, we need to remount with the HMAC
          See https://shopify.dev/docs/api/app-bridge-library/reference/navigation
          <li><a href="shopify:admin/apps/my-shopify-app-mount/shop_admin" target="_top">Home</a></li>
        --%>
        <li><.link patch={~p"/live_shop_admin/"}>Home</.link></li>
        <li><.link patch={~p"/live_shop_admin/show"}>Show</.link></li>
        <li><.link patch={~p"/live_shop_admin/settings"}>Settings</.link></li>
        <li><.link patch={~p"/live_shop_admin/more"}>More Settings</.link></li>
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
      data-phx-hook="ShopifyToastHook"
      hidden
    >
      <%= msg %>
    </div>
    """
  end

  @doc """
  Renders a button.

  ## Examples

      <.button>Send!</.button>
      <.button data-phx-click="go" class="ml-2">Send!</.button>
  """
  attr :type, :string, default: nil
  attr :class, :string, default: nil
  attr :variant, :string, default: nil
  attr :rest, :global, include: ~w(disabled form name value)

  slot :inner_block, required: true

  def button(assigns) do
    ~H"""
    <button
      type={@type}
      variant={@variant}
      class={[
        "phx-submit-loading:opacity-75 rounded-lg bg-zinc-900 hover:bg-zinc-700 py-2 px-3",
        "text-sm font-semibold leading-6 text-white active:text-white/80",
        @class
      ]}
      {@rest}
    >
      <%= render_slot(@inner_block) %>
    </button>
    """
  end
end
