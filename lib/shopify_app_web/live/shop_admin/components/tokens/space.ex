defmodule ShopifyAppWeb.ShopAdmin.Tokens.Space do
  @moduledoc """
  Captures the Polaris Space Tokens. Allows enforcing of component attributes

  See https://polaris.shopify.com/tokens/space
  """

  @tokens [
    "32",
    "28",
    "24",
    "20",
    "16",
    "12",
    "10",
    "8",
    "6",
    "5",
    "4",
    "3",
    "2",
    "1",
    "05",
    "table-cell-padding",
    "card-padding",
    "card-gap",
    "button-group-gap",
    "3200",
    "2800",
    "2400",
    "2000",
    "1600",
    "1200",
    "1000",
    "800",
    "600",
    "500",
    "400",
    "300",
    "200",
    "150",
    "100",
    "050",
    "025",
    "0"
  ]

  def tokens, do: @tokens

  def var(colour) when colour in @tokens, do: "var(--p-space-#{colour})"
end
