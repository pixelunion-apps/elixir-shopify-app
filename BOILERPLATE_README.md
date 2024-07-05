# ShopifyApp

## Prerequisite

- [asdf](https://asdf-vm.com/)
- Docker / Docker Compose
- Access to a Shopify Partners Dashboard
- An ngrok account

## Development

- install with asdf (install the plugins first if you do not have them, e.g. `asdf plugin-add elixir`)
    - `asdf install`
- Setup environment variables
    - ensure direnv is working `https://direnv.net/docs/hook.html`
    - Create .envrc.private `cp .envrc.private.example .envrc.private` and update values.
- Start database and ngrok
    - `docker-compose up`
- Create Shopify App and Shop
- Fetch Elixir Deps, create database
    - `mix deps.get`
    - `mix ecto.setup`

### Running

- Run the app locally with `mix phx.server` or `iex -S mix phx.server` for a REPL.

### Shop Install

- Install the the app to a shopify shop with https://mysubdomain.ngrok.io/shop/install?shop=myshop.myshopify.com&app=shopify_app (replacing `mysubdomain` and `app=shopify_app`)

# Organization

## Shop Admin

The Shop Admin is a place inside of Shopify that the merchant can access and configure the app.

The ShopAdmin is serverd up as a LiveView in an iframe. It uses [AppBridge](https://shopify.dev/docs/api/app-bridge-library/reference) to communicate with the parent. It uses [Polaris](https://polaris.shopify.com) as the design language.

### Implementation Notes

The ShopAdmin lives on the `/shop_admin/:app` route and is part of the `:shop_admin` live_session. Most of the relevant files can be found in `lib/shopify_app_web/live/shop_admin/`. The ShopAdmin has its own root and app layouts, including its own JS which adds a few extra considerations for interacting with AppBridge.

#### AppBridge Considerations

- We hook `phx:page-loading-start` events into [AppBridge loading](https://shopify.dev/docs/api/app-bridge-library/reference/loading)
- We can interact with the AppBride [Title Bar with `<ui-title-bar/>` componenet](https://shopify.dev/docs/api/app-bridge-library/reference/navigation-menu). We can add action buttons to the title bar. However `<ui-title-bar/>` requires that attributes of any of its children do not take the form of `phx-` such as `phx-click`, **instead we must use the `data-phx-` prefix** ( `bindingPrefix: "data-phx-"`). This affects all LiveViews using `use ShopifyAppWeb, :shop_admin_live_view`, which should be all and only ShopAdmin LiveViews. This unfortunately means that we cannot share CoreComponents between ShopAdmin and non ShopAdmin LiveViews.
- We can interact with the AppBridge [Navigation Menu with `ui-nav-menu`](https://shopify.dev/docs/api/app-bridge-library/reference/navigation-menu). This lives in `lib/shopify_app_web/live/shop_admin/layouts/app.html.heex`. AppBridge __should__ detect any navigation within the iframe and reflect that in the Navigation Menu, we re-trigger `history.replaceState` when we navigate between liveviews to give it an extra nudge. In general, AppBridge Navigation Menu updates does not work unless you enter into ShopAdmin from the root path (ie. `/shop_admin/:app` not `/shop_admin/:app/settigns`)
- Instead of traditional `<.flash />` for flash messages, we use the [LiveBridge Toast](https://shopify.dev/docs/api/app-bridge-library/reference/toast) with `<.toast />` (using `ShopifyToastHook`). The toast is still activated with `put_flash/3`.
