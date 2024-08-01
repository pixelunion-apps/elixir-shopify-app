defmodule ShopifyApp.Schema.AuthToken do
  @moduledoc false
  use ShopifyApp.Schema
  import Ecto.Changeset

  schema "auth_tokens" do
    field :app_name, :string
    field :plus, :boolean, default: false
    field :shop_name, :string
    field :token, :string

    timestamps()
  end

  @doc false
  def changeset(auth_token, attrs) do
    auth_token
    |> cast(attrs, [:app_name, :shop_name, :token, :plus])
    |> validate_required([:app_name, :shop_name, :token, :plus])
  end
end
