# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :shopify_app,
  ecto_repos: [ShopifyApp.Repo]

# Configures the endpoint
config :shopify_app, ShopifyAppWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [
    formats: [html: ShopifyAppWeb.ErrorHTML, json: ShopifyAppWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: ShopifyApp.PubSub,
  live_view: [signing_salt: "ohBcnlqz"]

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :shopify_app, ShopifyApp.Mailer, adapter: Swoosh.Adapters.Local

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.14.41",
  default: [
    args:
      ~w(js/app.js js/shop_admin.js js/storybook.js --bundle --target=es2017 --outdir=../priv/static/assets --external:/fonts/* --external:/images/*),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

# Configure tailwind (the version is required)
config :tailwind,
  version: "3.2.4",
  default: [
    args: ~w(
      --config=tailwind.config.js
      --input=css/app.css
      --output=../priv/static/assets/app.css
    ),
    cd: Path.expand("../assets", __DIR__)
  ],
  storybook: [
    args: ~w(
            --config=tailwind.config.js
            --input=css/storybook.css
            --output=../priv/static/assets/storybook.css
          ),
    cd: Path.expand("../assets", __DIR__)
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time [$level] $message [$metadata]\n",
  metadata: [:request_id, :mta, :error, :myshopify_domain, :shopify_object_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

###################
# ShopifyAPI Config
###################
config :shopify_api, ShopifyAPI.AuthTokenServer,
  initializer: {ShopifyApp.ShopifyAPI.Initializer, :auth_token_init, []},
  persistence: {ShopifyApp.ShopifyAPI.Initializer, :auth_token_persist, []}

config :shopify_api, ShopifyAPI.AppServer,
  initializer: {ShopifyApp.ShopifyAPI.Initializer, :app_init, []},
  persistence: nil

config :shopify_api, ShopifyAPI.ShopServer,
  initializer: {ShopifyApp.ShopifyAPI.Initializer, :shop_init, []},
  persistence: {ShopifyApp.ShopifyAPI.Initializer, :shop_persist, []}

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
