defmodule Storybook.PolarisComponents.Spinner do
  use PhoenixStorybook.Story, :component

  def function, do: &Elixir.ShopifyAppWeb.ShopAdmin.PolarisComponents.Spinner.spinner/1

  def variations do
    [
      %VariationGroup{
        id: :default,
        variations: [
          %Variation{
            id: :default,
            attributes: %{
              accessibility_label: "Spinner example",
              size: "large"
            }
          },
          %Variation{
            id: :small,
            attributes: %{
              accessibility_label: "Small spinner example",
              size: "small"
            }
          }
        ]
      }
    ]
  end
end
