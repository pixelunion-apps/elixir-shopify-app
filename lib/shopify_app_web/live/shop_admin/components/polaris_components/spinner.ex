defmodule ShopifyAppWeb.ShopAdmin.PolarisComponents.Spinner do
  @moduledoc """
  Spinners are used to notify merchants that their action is being processed. For loading states, spinners should only be used for content that can’t be represented with skeleton loading components, like for data charts.

  ## Examples

      <.spinner size="small" accessibility_label="loading" />

      <.spinner size="large" accessibility_label="loading" />

  See
    - https://polaris.shopify.com/components/feedback-indicators/spinner
    - https://github.com/Shopify/polaris/blob/main/polaris-react/src/components/Spinner/Spinner.tsx
  """

  use Phoenix.Component

  @doc @moduledoc

  attr :accessibility_label, :string, required: true
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
