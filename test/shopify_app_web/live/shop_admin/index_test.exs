defmodule ShopifyAppWeb.ShopAdminLive.IndexTest do
  use ShopifyAppWeb.ConnCase, async: true

  import Phoenix.LiveViewTest
  import ShopifyApp.ShopTestSetup

  describe "ShopAdminLive.Index render" do
    setup [:shop]

    test "disconnected and connected mount", %{conn: conn, shopifyapi_shop: shop} do
      conn =
        conn
        |> assign(:shop, shop)
        |> get("/shop_admin/shopify_shop")

      assert html_response(conn, 200) =~ "Example <strong>Home</strong> LiveView"

      {:ok, _view, _html} = live(conn)
    end
  end
end
