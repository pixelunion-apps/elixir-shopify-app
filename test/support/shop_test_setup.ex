defmodule ShopifyApp.ShopTestSetup do
  import ShopifyApp.Factory

  def app_auth_token_shop(context) do
    shop_context = shop(context)
    shop = Keyword.fetch!(shop_context, :shop)
    shopifyapi_shop = Keyword.fetch!(shop_context, :shopifyapi_shop)
    [app: app] = app(context)
    [token: token] = auth_token(%{shop: shop})
    [shop_admin_token: shop_admin_token] = shop_admin_token(%{shop: shop, app: app})

    [
      app: app,
      auth_token: token,
      shop: shop,
      shopifyapi_shop: shopifyapi_shop,
      shop_admin_token: shop_admin_token
    ]
  end

  def shopifyapi_bypass(_context) do
    bypass = Bypass.open()

    [bypass: bypass, myshopify_domain: "localhost:#{bypass.port}"]
  end

  def shop(context) do
    myshopify_domain = Map.get(context, :myshopify_domain, myshopify_domain())
    shop = insert(:shop, myshopify_domain: myshopify_domain)

    shopifyapi_shop = %ShopifyAPI.Shop{domain: shop.myshopify_domain}
    ShopifyAPI.ShopServer.set(shopifyapi_shop, false)

    [shop: shop, shopifyapi_shop: shopifyapi_shop, myshopify_domain: myshopify_domain]
  end

  def app(_context) do
    app = %ShopifyAPI.App{
      name: ShopifyApp.Config.app_name(),
      client_id: "#{__MODULE__}.id",
      client_secret: "secret"
    }

    ShopifyAPI.AppServer.set(app)
    [app: app]
  end

  def shop_admin_token(%{app: app, shop: shop}) do
    payload = %{"aud" => app.client_id, "dest" => "https://#{shop.myshopify_domain}"}
    jwk = JOSE.JWK.from_oct(app.client_secret)
    {_, jwt} = jwk |> JOSE.JWT.sign(%{"alg" => "HS256"}, payload) |> JOSE.JWS.compact()

    [shop_admin_token: jwt]
  end

  def auth_token(%{shop: %{myshopify_domain: myshopify_domain}}) do
    token = %ShopifyAPI.AuthToken{
      shop_name: myshopify_domain,
      app_name: ShopifyApp.Config.app_name()
    }

    ShopifyAPI.AuthTokenServer.set(token, false)

    [token: token]
  end
end
