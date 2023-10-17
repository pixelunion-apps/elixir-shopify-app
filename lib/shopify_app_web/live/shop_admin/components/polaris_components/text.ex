defmodule ShopifyAppWeb.ShopAdmin.PolarisComponents.Text do
  @moduledoc """
  Text

  Typography helps establish hierarchy and communicate important content by creating clear visual patterns.

  ## Examples

    <.text variant="bodyLg" as="p" alignment="center">center alignment</.text>
    <.text as="p" tone="caution">cautious text</.text>

  See
    - https://polaris.shopify.com/components/typography/text
    - https://github.com/Shopify/polaris/blob/main/polaris-react/src/components/Text/Text.tsx
  """

  @doc @moduledoc

  use Phoenix.Component

  attr :alignment, :string,
    values: ["start", "center", "end", "justify"],
    doc: "Adjust horizontal alignment of text"

  attr :as, :string,
    values: [
      "dt",
      "dd",
      "h1",
      "h2",
      "h3",
      "h4",
      "h5",
      "h6",
      "p",
      "span",
      "strong",
      "legend"
    ],
    doc: "The element type"

  attr :break_word, :boolean, doc: "Prevent text from overflowing"

  attr :tone, :string,
    values: ["success", "critical", "caution", "subdued", "text-inverse"],
    doc: "Adjust tone of text"

  attr :font_weight, :string,
    values: ["regular", "medium", "semibold", "bold"],
    doc: "Adjust weight of text"

  attr :numeric, :boolean, doc: "Use a numeric font variant with monospace appearance"
  attr :truncate, :boolean, doc: "Truncate text overflow with ellipsis"

  attr :variant, :string,
    values: [
      "headingSm",
      "headingMd",
      "headingLg",
      "headingXl",
      "heading2xl",
      "heading3xl",
      "bodySm",
      "bodyMd",
      "bodyLg"
    ],
    doc: "Typographic style of text"

  attr :visually_hidden, :boolean, doc: "Visually hide the text"

  attr :text_decoration_line, :string,
    values: ["line-through"],
    doc: "Add a line-through to the text"

  slot :inner_block, required: true

  def text(assigns) do
    assigns = assign(assigns, :class, "Polaris-Text--root " <> text_build_class(assigns))

    ~H"""
    <.as element={@as} class={@class}>
      <%= render_slot(@inner_block) %>
    </.as>
    """
  end

  defp text_build_class(attrs) when is_map(attrs),
    do: attrs |> Enum.flat_map(&text_class/1) |> Enum.join(" ")

  def text_class({:visually_hidden, true}), do: ["Polaris-Text--visuallyHidden"]
  def text_class({:numeric, true}), do: ["Polaris-Text--numeric"]
  def text_class({:break_word, true}), do: ["Polaris-Text--break"]
  def text_class({:truncate, true}), do: ["Polaris-Text--truncate", "Polaris-Text--block"]
  def text_class({:alignment, value}), do: ["Polaris-Text--#{value}", "Polaris-Text--block"]
  def text_class({:tone, value}), do: ["Polaris-Text--#{value}"]
  def text_class({:font_weight, value}), do: ["Polaris-Text--#{value}"]
  def text_class({:variant, value}), do: ["Polaris-Text--#{value}"]
  def text_class({:text_decoration_line, value}), do: ["Polaris-Text--#{value}"]
  def text_class({_key, _value}), do: []

  @doc """
  As

  A helper for setting the underlaying element of a component
  """
  attr :element, :string,
    values: [
      "dt",
      "dd",
      "h1",
      "h2",
      "h3",
      "h4",
      "h5",
      "h6",
      "p",
      "span",
      "strong",
      "legend"
    ],
    required: true

  attr :rest, :global

  slot :inner_block, required: true

  def as(%{element: "dt"} = assigns),
    do: ~H"<dt {@rest}><%= render_slot(@inner_block) %></dt>"

  def as(%{element: "dd"} = assigns),
    do: ~H"<dd {@rest}><%= render_slot(@inner_block) %></dd>"

  def as(%{element: "h1"} = assigns),
    do: ~H"<h1 {@rest}><%= render_slot(@inner_block) %></h1>"

  def as(%{element: "h2"} = assigns),
    do: ~H"<h2 {@rest}><%= render_slot(@inner_block) %></h2>"

  def as(%{element: "h3"} = assigns),
    do: ~H"<h3 {@rest}><%= render_slot(@inner_block) %></h3>"

  def as(%{element: "h4"} = assigns),
    do: ~H"<h4 {@rest}><%= render_slot(@inner_block) %></h4>"

  def as(%{element: "h5"} = assigns),
    do: ~H"<h5 {@rest}><%= render_slot(@inner_block) %></h5>"

  def as(%{element: "h6"} = assigns),
    do: ~H"<h6 {@rest}><%= render_slot(@inner_block) %></h6>"

  def as(%{element: "p"} = assigns),
    do: ~H"<p {@rest}><%= render_slot(@inner_block) %></p>"

  def as(%{element: "span"} = assigns),
    do: ~H"<span {@rest}><%= render_slot(@inner_block) %></span>"

  def as(%{element: "strong"} = assigns),
    do: ~H"<strong {@rest}><%= render_slot(@inner_block) %></strong>"

  def as(%{element: "legend"} = assigns),
    do: ~H"<legend {@rest}><%= render_slot(@inner_block) %></legend>"
end
