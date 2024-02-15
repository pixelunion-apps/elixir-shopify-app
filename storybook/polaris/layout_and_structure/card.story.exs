defmodule Storybook.PolarisComponents.Card do
  use PhoenixStorybook.Story, :component

  def imports, do: [{ShopifyAppWeb.ShopAdmin.PolarisComponents.Text, text: 1}]

  def function, do: &ShopifyAppWeb.ShopAdmin.PolarisComponents.Card.card/1

  def variations do
    [
      %VariationGroup{
        id: :default,
        variations: [
          %Variation{
            id: :default,
            slots: [~s|<.text as="h2" variant="bodyMd">Content inside a card</.text>|],
            attributes: %{}
          }
        ]
      },
      %VariationGroup{
        id: :with_subdued_background,
        variations: [
          %Variation{
            id: :with_subdued_background,
            slots: [~s|<.text as="h2" variant="bodyMd">Content inside a card</.text>|],
            attributes: %{
              background: "bg-surface-secondary"
            }
          }
        ]
      },
      %VariationGroup{
        id: :with_varying_padding,
        variations: [
          %Variation{
            id: :with_varying_padding_none,
            slots: [~s|<.text as="h2" variant="bodyMd">Content inside a card</.text>|],
            attributes: %{}
          },
          %Variation{
            id: :with_varying_padding_400,
            slots: [~s|<.text as="h2" variant="bodyMd">Content inside a card</.text>|],
            attributes: %{
              padding: "400"
            }
          },
          %Variation{
            id: :with_varying_padding_200,
            slots: [~s|<.text as="h2" variant="bodyMd">Content inside a card</.text>|],
            attributes: %{
              padding: "200"
            }
          },
          %Variation{
            id: :with_varying_padding_0,
            slots: [~s|<.text as="h2" variant="bodyMd">Content inside a card</.text>|],
            attributes: %{
              padding: "0"
            }
          }
        ]
      },
      %VariationGroup{
        id: :rounded_corners,
        variations: [
          %Variation{
            id: :rounded_corners,
            slots: [~s|<.text as="h2" variant="bodyMd">Content inside a card</.text>|],
            attributes: %{
              rounded_above: "md",
              background: "bg-surface-secondary"
            }
          }
        ]
      }
    ]
  end
end
