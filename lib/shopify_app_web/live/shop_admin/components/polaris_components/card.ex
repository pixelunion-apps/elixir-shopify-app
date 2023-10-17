defmodule ShopifyAppWeb.ShopAdmin.PolarisComponents.Card do
  @moduledoc """
  Card

  Cards are used to group similar concepts and tasks together for merchants to scan, read, and get things done. It displays content in a familiar and recognizable style.

  ## Examples

    <.card><.text as="h2">Content inside a card</.text></.card>
    <.card rounded_above="sm" background="bg-surface-secondary" padding="400"><.text as="h2">Content inside a card</.text></.card>

  See
   - https://polaris.shopify.com/components/layout-and-structure/card
   - https://github.com/Shopify/polaris/blob/main/polaris-react/src/components/Card/tests/Card.test.tsx
  """

  use Phoenix.Component

  import ShopifyAppWeb.ShopAdmin.PolarisComponents.Box
  import ShopifyAppWeb.ShopAdmin.PolarisComponents.ShadowBevel

  alias ShopifyAppWeb.ShopAdmin.Tokens.Colour

  @doc @moduledoc

  attr :background, :string, values: Colour.tokens(), default: "bg-surface"

  attr :padding, :list,
    default: [xs: "400"],
    doc: "A tuple with the size and Space token",
    examples: [[xs: "400", lg: "500"]]

  attr :rounded_above, :string,
    values: ["xs", "sm", "md", "lg", "xl"],
    doc: "Border radius value above a set breakpoint."

  slot :inner_block, required: true

  def card(assigns) do
    assigns = assign(assigns, :border_radius, border_radius(assigns))

    ~H"""
    <.shadow_bevel box_shadow={[xs: "100"]} border_radius={@border_radius} z_index="32">
      <.box
        background={@background}
        padding={@padding}
        overflow_x="hidden"
        overflow_y="hidden"
        min_height="100%"
      >
        <%= render_slot(@inner_block) %>
      </.box>
    </.shadow_bevel>
    """
  end

  @doc """
  Builds the border radius to pass to ShadowBevel.
  Strangely, even t
  """
  def border_radius(%{rounded_above: responsive}),
    do: [{:xs, "0"}, {String.to_atom(responsive), "300"}]

  def border_radius(_), do: [{:xs, "300"}]
end
