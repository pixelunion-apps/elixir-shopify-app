defmodule ShopifyApp.Schema.UserToken do
  @moduledoc false
  use ShopifyApp.Schema
  import Ecto.Changeset

  alias ShopifyApp.Schema

  @type t :: %__MODULE__{}

  schema "user_tokens" do
    field :app_name, :string
    field :code, :string
    field :token, :string
    field :associated_user_id, :integer
    field :associated_user_scope, :string
    field :timestamp, :integer
    field :plus, :boolean, default: false
    field :scope, :string
    field :expires_in, :integer
    field :associated_user, :map

    belongs_to :shop, Schema.Shop,
      references: :myshopify_domain,
      foreign_key: :shop_myshopify_domain,
      type: :string

    timestamps()
  end

  @doc false
  def changeset(auth_token, attrs) do
    auth_token
    |> cast(attrs, [
      :app_name,
      :shop_myshopify_domain,
      :code,
      :token,
      :associated_user_id,
      :associated_user_scope,
      :timestamp,
      :plus,
      :scope,
      :expires_in,
      :associated_user
    ])
    |> validate_required([:app_name, :shop_myshopify_domain, :token, :plus])
  end
end
