defmodule ShopifyAppWeb.ShopAdmin.PolarisComponents.ShadowBevel do
  @moduledoc """
  ShadowBevel

  A building block for other components such as Card

  See
   - https://github.com/Shopify/polaris/blob/main/polaris-react/src/components/ShadowBevel/ShadowBevel.tsx
  """

  use Phoenix.Component

  alias ShopifyAppWeb.ShopAdmin.StyleBuilder
  alias ShopifyAppWeb.ShopAdmin.Tokens.Border
  alias ShopifyAppWeb.ShopAdmin.Tokens.Shaddow

  attr :box_shadow, :list, doc: "The box-shadow applied to the root element."

  attr :border_radius, :list,
    doc: "The border-radius applied to both the root and pseudo elements."

  attr :z_index, :string,
    values: ["0", "32"],
    default: "0",
    doc: "The z-index applied to the pseudo element."

  attr :bevel, :boolean,
    default: true,
    values: [true],
    doc:
      "Enable/disable the bevel effect. Note: This also disables the border-radius and box-shadow."

  slot :inner_block, required: true

  @polaris_style_attributes %{
    box_shadow: [formater: &Shaddow.var/1, responsive: true],
    border_radius: [formater: &Border.radius/1, responsive: true],
    z_index: [formater: &StyleBuilder.identity/1]
  }
  def shadow_bevel(assigns) do
    style =
      "--pc-shadow-bevel-content-xs:\"\";" <>
        StyleBuilder.build("--pc-shadow-bevel", assigns, @polaris_style_attributes)

    assigns = assign(assigns, :style, style)

    ~H"""
    <div class="Polaris-ShadowBevel" style={@style}>
      <%= render_slot(@inner_block) %>
    </div>
    """
  end
end
