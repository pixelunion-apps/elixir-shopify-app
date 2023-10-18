defmodule ShopifyAppWeb.Router do
  use ShopifyAppWeb, :router

  import PhoenixStorybook.Router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {ShopifyAppWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :shop_admin do
    plug ShopifyAPI.Plugs.AdminAuthenticator, app_name: "shopify_app"
    plug ShopifyAPI.Plugs.PutShopifyContentHeaders
  end

  pipeline :shop_admin_api do
    plug :accepts, ["json"]
    plug ShopifyAPI.Plugs.AuthShopSessionToken
  end

  scope "/" do
    storybook_assets()
  end

  scope "/", ShopifyAppWeb do
    pipe_through :browser

    get "/", PageController, :index
    live_storybook("/storybook", backend_module: ShopifyAppWeb.Storybook)
  end

  scope "/shop", ShopifyAPI do
    forward("/", Router)
  end

  scope "/api" do
    scope "/admin" do
      pipe_through :shop_admin_api

      forward "/", ShopifyApp.Plug.AdminAbsintheWrapper, schema: ShopifyAppGraphQL.AdminSchema
    end
  end

  live_session :live_shop_admin,
    layout: {ShopifyAppWeb.ShopAdminLive.Layouts, :app},
    root_layout: {ShopifyAppWeb.ShopAdminLive.Layouts, :root},
    on_mount: [ShopifyAppWeb.ShopAdminLive.AssignScope],
    session: {ShopifyAppWeb.ShopAdminLive.AssignScope, :build_session, []} do
    scope "/live_shop_admin", ShopifyAppWeb do
      pipe_through :browser
      pipe_through :shop_admin

      live "/", ShopAdminLive.Index, :live
      live "/show", ShopAdminLive.Index, :show
      live "/settings", ShopAdminLive.Settings, :settings
      live "/more", ShopAdminLive.Settings, :more_settings
    end
  end

  # Other scopes may use custom stacks.
  # scope "/api", ShopifyAppWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:shopify_app, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: ShopifyAppWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end

  @spec webhooks_url() :: String.t()
  def webhooks_url do
    ShopifyAppWeb.Endpoint.struct_url() |> URI.append_path("/shopify/webhook") |> URI.to_string()
  end
end
