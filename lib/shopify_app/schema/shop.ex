defmodule ShopifyApp.Schema.Shop do
  @moduledoc false
  use ShopifyApp.Schema
  import Ecto.Changeset

  @type t :: %__MODULE__{}

  schema "shops" do
    field :myshopify_domain, :string

    timestamps()
  end

  @doc false
  def changeset(shop, attrs) do
    shop
    |> cast(attrs, [:myshopify_domain])
    |> validate_required([:myshopify_domain])
  end
end
