defmodule ShopifyAppWeb.ShopAdmin.Tokens.Border do
  @moduledoc """
  Captures the Polaris Border Tokens. Allows enforcing of component attributes

  See https://polaris.shopify.com/tokens/border
  """

  @width_tokens [
    "5",
    "4",
    "3",
    "2",
    "1",
    "100",
    "050",
    "025",
    "0165"
  ]

  @radious_tokens [
    "6",
    "5",
    "4",
    "3",
    "2",
    "1",
    "05",
    "full",
    "750",
    "500",
    "400",
    "300",
    "200",
    "150",
    "100",
    "050",
    "0"
  ]

  @tokens [
    "width-5",
    "width-4",
    "width-3",
    "width-2",
    "width-1",
    "width-100",
    "width-050",
    "width-025",
    "width-0165",
    "radius-6",
    "radius-5",
    "radius-4",
    "radius-3",
    "radius-2",
    "radius-1",
    "radius-05",
    "radius-full",
    "radius-750",
    "radius-500",
    "radius-400",
    "radius-300",
    "radius-200",
    "radius-150",
    "radius-100",
    "radius-050",
    "radius-0"
  ]

  def tokens, do: @tokens

  def width_tokens, do: @width_tokens

  def radious_tokens, do: @radious_tokens

  def var(border) when border in @tokens, do: "var(--p-border-#{border})"

  def radius(border) when border in @radious_tokens, do: "var(--p-border-radius-#{border})"

  def width(border) when border in @width_tokens, do: "var(--p-border-width-#{border})"
end
