defmodule ShopifyAppWeb.ShopAdmin.StyleBuilder do
  @moduledoc """
  Builds Polaris styles from style options and assigns.

  Style options are a tuple with the name of the option and the
    - requires: A list of styles additional styles will be automatically be included.
      For example, `border_color` always requires `border_style` to be set.
    - default: The default value to use for an automatically included style.
      For example, for `border_style`, this would be `"solid"`.
      For `padding_block_start`, this would be the value set for `padding`.
    - formater: A function that takes the supplied attributes and returns the formated variable.
      For example, `Border.radius("5")` will return `"var(--p-border-radius-5)"`, giving us `"--my_prefix-border-radius:var(--p-border-radius-5)"`
    - responsive: A boolean representing if the attribute accepts responsive tuples.
      For example, `padding={[xs: "400", lg: "500"]}`

    eg.
      {:padding_block_start, [formater: &Space.var/1, responsive: true, default: :padding]},
      {:border_style, [formater: &StyleBuilder.identity/1, default: "solid"]},
      {:border_width, [formater: &Border.width/1, requires: :border_style]}
  """

  def build(prefix, assigns, style_definitions) do
    style_keys = Map.keys(style_definitions)
    styles = Map.take(assigns, style_keys)

    styles
    |> expand_required_styles(style_definitions)
    |> expand_responsive(style_definitions)
    |> format_styles(style_definitions, prefix)
  end

  def expand_required_styles(styles, style_definitions) do
    styles
    |> Enum.flat_map(fn {style_key, _value} -> get_requires(style_definitions, style_key) end)
    |> Enum.map(fn required_style ->
      {required_style, get_default(style_definitions, required_style)}
    end)
    |> Enum.map(fn
      {required_style, default} when is_atom(default) ->
        {required_style, Map.get(styles, default)}

      {required_style, default} when is_binary(default) ->
        {required_style, default}
    end)
    |> Map.new()
    |> Map.merge(styles)
  end

  def expand_responsive(styles, style_definitions) do
    Enum.flat_map(styles, fn {style_key, value} ->
      if get_responsive(style_definitions, style_key) do
        get_responsive_values({style_key, value})
      else
        [{style_key, value}]
      end
    end)
  end

  defp get_responsive_values({key, values}) when is_list(values),
    do: Enum.map(values, fn {size, value} -> {key, {size, value}} end)

  defp get_responsive_values({key, value}) when is_binary(value),
    do: get_responsive_values({key, [xs: value]})

  def format_styles(styles, style_definitions, prefix) do
    Enum.map_join(styles, ";", fn
      {key, {size, value}} ->
        formatter = get_formater(style_definitions, key)
        "#{prefix}-#{strike_through(key)}-#{size}:#{formatter.(value)}"

      {key, value} ->
        formatter = get_formater(style_definitions, key)
        "#{prefix}-#{strike_through(key)}:#{formatter.(value)}"
    end)
  end

  defp strike_through(key), do: key |> Atom.to_string() |> String.replace("_", "-")

  defp get_requires(style_definitions, key),
    do: style_definitions |> Map.get(key) |> Keyword.get(:requires, []) |> List.wrap()

  defp get_default(style_definitions, key),
    do: style_definitions |> Map.get(key) |> Keyword.get(:default)

  defp get_formater(style_definitions, key),
    do: style_definitions |> Map.get(key) |> Keyword.get(:formater)

  defp get_responsive(style_definitions, key),
    do: style_definitions |> Map.get(key) |> Keyword.get(:responsive)

  def identity(string) when is_binary(string), do: string
end
