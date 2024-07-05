defmodule ShopifyAppWeb.ShopAdmin.Tokens.Shaddow do
  @moduledoc """
  Captures the Polaris Shaddow Tokens. Allows enforcing of component attributes

  See https://polaris.shopify.com/tokens/shaddow
  """

  @tokens [
    "2xl",
    "xl",
    "lg",
    "md",
    "sm",
    "xs",
    "none",
    "inset-sm",
    "inset-md",
    "inset-lg",
    "border-inset",
    "button-primary-success-inset",
    "button-primary-success-hover",
    "button-primary-success",
    "button-primary-critical-inset",
    "button-primary-critical-hover",
    "button-primary-critical",
    "button-primary-inset",
    "button-primary-hover",
    "button-primary",
    "button-inset",
    "button-hover",
    "button",
    "inset-200",
    "inset-100",
    "bevel-100",
    "600",
    "500",
    "400",
    "300",
    "200",
    "100",
    "0"
  ]

  def tokens, do: @tokens

  def var(colour) when colour in @tokens, do: "var(--p-shadow-#{colour})"
end
