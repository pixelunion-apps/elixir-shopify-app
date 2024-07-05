defmodule ShopifyAppWeb.ShopAdminLive.AssignScope do
  @moduledoc """
  Handles session authentication for ShopAdmin LiveViews.
  This allows for patch navigation within a live_session.

  This has a prerequisite of the user being authenticated through
  the AuthShopSessionToken or AdminAuthenticator plug first
  and we have the app and shop in the assigns.
  We populate the session with the `app_name` and `myshopify_domain` from the assigns.
  We can now populate the socket assigns from the session and the respective servers.

  This is a good canditate for something that should be moved into ShopifyAPI.

  # Example

    live_session :my_session,
      session: {ShopifyAppWeb.ShopAdminLive.AssignScope, :session, []}
      on_mount: [ShopifyAppWeb.ShopAdminLive.AssignScope] do
        ...
    end
  """
  import Phoenix.Component

  alias ShopifyAPI.AppServer
  alias ShopifyAPI.AuthTokenServer
  alias ShopifyAPI.ShopServer

  require Logger

  @doc """
  Pull app and shop out of the assigns to store it in the session.

  Session data is signed but not private so we are only storing the name and the domain.
  """
  def build_session(%{assigns: %{app: app, shop: shop}})
      when is_struct(app, ShopifyAPI.App) and
             is_struct(shop, ShopifyAPI.Shop),
      do: %{"app_name" => app.name, "myshopify_domain" => shop.domain}

  @doc """
  Build the assigns from the app name and the shop domain put in the session with build_session.
  """
  def on_mount(:default, _params, session, socket) do
    with {:ok, app} <- fetch_app(session["app_name"]),
         {:ok, shop} <- fetch_shop(session["myshopify_domain"]),
         {:ok, auth_token} <- AuthTokenServer.get(shop.domain, app.name) do
      {:cont, assign(socket, :scope, %{app: app, shop: shop, auth_token: auth_token})}
    else
      {:error, error} ->
        Logger.error("Invalid session info #{inspect(error)}")

        {:halt, socket}
    end
  end

  defp fetch_shop(myshopify_domain) do
    case ShopServer.get(myshopify_domain) do
      {:ok, shop} -> {:ok, shop}
      :error -> {:error, :shop_not_found}
    end
  end

  defp fetch_app(app_name) do
    case AppServer.get(app_name) do
      {:ok, app} -> {:ok, app}
      :error -> {:error, :app_not_found}
    end
  end
end
