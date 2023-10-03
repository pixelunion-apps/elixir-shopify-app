defmodule ShopifyAppWeb.ShopAdmin.PolarisComponents do
  @moduledoc """
  Polaris Components

  These components are an implementation of the Shopify Polaris design system.

  Style attributes are taken from Polaris Tokens. https://polaris.shopify.com/tokens/color

  See https://polaris.shopify.com/components
  """

  use Phoenix.Component

  alias ShopifyAppWeb.ShopAdmin.StyleBuilder
  alias ShopifyAppWeb.ShopAdmin.Tokens.Border
  alias ShopifyAppWeb.ShopAdmin.Tokens.Colour
  alias ShopifyAppWeb.ShopAdmin.Tokens.Shaddow
  alias ShopifyAppWeb.ShopAdmin.Tokens.Space

  @doc """
  Spinner

  ## Examples

  <.spinner size="small" accessibility_label="loading" />
  <.spinner size="large" accessibility_label="loading" />

  See
    - https://polaris.shopify.com/components/feedback-indicators/spinner
    - https://github.com/Shopify/polaris/blob/main/polaris-react/src/components/Spinner/Spinner.tsx
  """

  attr :accessibility_label, :string
  attr :size, :string, values: ["small", "large"], default: "small"
  attr :has_focusable_parent, :boolean, default: false

  def spinner(assigns) do
    role = if assigns.has_focusable_parent, do: "", else: "status"

    assigns = assign(assigns, :role, role)

    ~H"""
    <span class={"Polaris-Spinner Polaris-Spinner--size#{String.capitalize(@size)}"}>
      <.variants value={@size}>
        <:variant name="small">
          <svg viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg">
            <path d="M7.229 1.173a9.25 9.25 0 1011.655 11.412 1.25 1.25 0 10-2.4-.698 6.75 6.75 0 11-8.506-8.329 1.25 1.25 0 10-.75-2.385z" />
          </svg>
        </:variant>
        <:variant name="large">
          <svg viewBox="0 0 44 44" xmlns="http://www.w3.org/2000/svg">
            <path d="M15.542 1.487A21.507 21.507 0 00.5 22c0 11.874 9.626 21.5 21.5 21.5 9.847 0 18.364-6.675 20.809-16.072a1.5 1.5 0 00-2.904-.756C37.803 34.755 30.473 40.5 22 40.5 11.783 40.5 3.5 32.217 3.5 22c0-8.137 5.3-15.247 12.942-17.65a1.5 1.5 0 10-.9-2.863z" />
          </svg>
        </:variant>
      </.variants>
    </span>
    <span role={@role}>
      <span class="Polaris-Text--root Polaris-Text--visuallyHidden"><%= @accessibility_label %></span>
    </span>
    """
  end

  @doc """
  Box

  Box is the most primitive layout component.

  ## Examples

    <.box border_color="border" border_width="4">Content</.box>
    <.box background="bg-magic-hover" border_radius="full" padding={[xs: "400"]} width="586px">Content</.box>

  See
    - https://polaris.shopify.com/components/layout-and-structure/box
    - https://github.com/Shopify/polaris/blob/main/polaris-react/src/components/Box/Box.tsx
  """
  attr :background, :string, values: Colour.tokens()
  attr :border_color, :string, values: Colour.tokens()
  attr :border_style, :string
  attr :border_radius, :string, values: Border.radious_tokens()
  attr :border_radius_end_start, :string, values: Border.radious_tokens()
  attr :border_radius_end_end, :string, values: Border.radious_tokens()
  attr :border_radius_start_start, :string, values: Border.radious_tokens()
  attr :border_radius_start_end, :string, values: Border.tokens()
  attr :border_width, :string, values: Border.width_tokens()
  attr :border_block_start_width, :string, values: Border.width_tokens()
  attr :border_block_end_width, :string, values: Border.width_tokens()
  attr :border_inline_start_width, :string, values: Border.width_tokens()
  attr :border_inline_end_width, :string, values: Border.width_tokens()
  attr :color, :string, values: Colour.tokens()
  attr :min_height, :string
  attr :min_width, :string
  attr :max_width, :string
  attr :overflow_x, :string
  attr :overflow_y, :string

  attr :padding, :list,
    doc: "A tuple with the size and Space token",
    examples: [[xs: "400", lg: "500"]]

  attr :padding_block_start, :list,
    doc: "A tuple with the size and Space token",
    examples: [[xs: "400", lg: "500"]]

  attr :padding_block_end, :list,
    doc: "A tuple with the size and Space token",
    examples: [[xs: "400", lg: "500"]]

  attr :padding_inline_start, :list,
    doc: "A tuple with the size and Space token",
    examples: [[xs: "400", lg: "500"]]

  attr :padding_inline_end, :list,
    doc: "A tuple with the size and Space token",
    examples: [[xs: "400", lg: "500"]]

  attr :shadow, :string, values: Shaddow.tokens()
  attr :width, :string
  attr :position, :string
  attr :inset_block_start, :string, values: Space.tokens()
  attr :inset_block_end, :string, values: Space.tokens()
  attr :inset_inline_start, :string, values: Space.tokens()
  attr :inset_inline_end, :string, values: Space.tokens()
  attr :opacity, :string
  attr :outline_color, :string, values: Colour.tokens()
  attr :outline_style, :string
  attr :outline_width, :string, values: Border.width_tokens()

  slot :inner_block, required: true

  @polaris_style_attributes %{
    background: [formater: &Colour.var/1],
    border_color: [formater: &Colour.var/1, requires: :border_style],
    border_style: [formater: &StyleBuilder.identity/1, default: "solid"],
    border_radius: [formater: &Border.radius/1],
    border_radius_end_start: [formater: &Border.radius/1],
    border_radius_end_end: [formater: &Border.radius/1],
    border_radius_start_start: [formater: &Border.radius/1],
    border_radius_start_end: [formater: &Border.radius/1],
    border_width: [formater: &Border.width/1, requires: :border_style],
    border_block_start_width: [formater: &Border.width/1, requires: :border_style],
    border_block_end_width: [formater: &Border.width/1, requires: :border_style],
    border_inline_start_width: [formater: &Border.width/1, requires: :border_style],
    border_inline_end_width: [formater: &Border.width/1, requires: :border_style],
    color: [formater: &Colour.var/1],
    min_height: [formater: &StyleBuilder.identity/1],
    min_width: [formater: &StyleBuilder.identity/1],
    max_width: [formater: &StyleBuilder.identity/1],
    overflow_x: [formater: &StyleBuilder.identity/1],
    overflow_y: [formater: &StyleBuilder.identity/1],
    padding: [
      formater: &Space.var/1,
      requires: [
        :padding_block_end,
        :padding_block_start,
        :padding_inline_start,
        :padding_inline_end
      ],
      responsive: true
    ],
    padding_block_start: [formater: &Space.var/1, responsive: true, default: :padding],
    padding_block_end: [formater: &Space.var/1, responsive: true, default: :padding],
    padding_inline_start: [formater: &Space.var/1, responsive: true, default: :padding],
    padding_inline_end: [formater: &Space.var/1, responsive: true, default: :padding],
    shadow: [formater: &Shaddow.var/1],
    width: [formater: &StyleBuilder.identity/1],
    position: [formater: &StyleBuilder.identity/1],
    inset_block_start: [formater: &Space.var/1],
    inset_block_end: [formater: &Space.var/1],
    inset_inline_start: [formater: &Space.var/1],
    inset_inline_end: [formater: &Space.var/1],
    opacity: [formater: &StyleBuilder.identity/1],
    outline_color: [formater: &Colour.var/1],
    outline_style: [formater: &StyleBuilder.identity/1, default: "solid"],
    outline_width: [formater: &Border.width/1]
  }
  def box(assigns) do
    style = StyleBuilder.build("--pc-box", assigns, @polaris_style_attributes)

    assigns = assign(assigns, :style, style)

    ~H"""
    <div class="Polaris-Box" style={@style}>
      <%= render_slot(@inner_block) %>
    </div>
    """
  end

  @doc """
  Variants

  A helper for setting a variant inside of a Polaris component.
  """
  attr :value, :string, required: true, doc: "Value of the variant, such as {size}"

  slot :variant do
    attr :name, :string, required: true, doc: "Name of the variant, such as \"small\""
  end

  def variants(assigns) do
    ~H"""
    <%= for var <- @variant do %>
      <%= if var.name == @value do %>
        <%= render_slot(var) %>
      <% end %>
    <% end %>
    """
  end
end
