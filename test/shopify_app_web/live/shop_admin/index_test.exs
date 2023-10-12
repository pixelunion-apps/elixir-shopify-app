defmodule ShopifyAppWeb.ShopAdminLive.IndexTest do
  use ShopifyAppWeb.ConnCase, async: true

  import Phoenix.LiveViewTest
  import ShopifyApp.ShopTestSetup

  describe "ShopAdminLive.Index render" do
    setup [:app_auth_token_shop]

    test "disconnected and connected mount", %{conn: conn, shopifyapi_shop: shop, app: app} do
      conn =
        conn
        |> assign(:shop, shop)
        |> assign(:app, app)
        |> get("/live_shop_admin")

      assert html_response(conn, 200) =~ "Example <strong>Home</strong> LiveView"

      {:ok, _view, _html} = live(conn)
    end
  end
end
