defmodule Storybook.PolarisComponents.Box do
  @moduledoc """
  Taken form https://github.com/Shopify/polaris/tree/main/polaris-react/src/components/Box/Box.stories.tsx
  """
  use PhoenixStorybook.Story, :component

  def imports, do: [{ShopifyAppWeb.ShopAdmin.PolarisComponents.Text, text: 1}]

  def function, do: &ShopifyAppWeb.ShopAdmin.PolarisComponents.Box.box/1

  def variations do
    [
      %VariationGroup{
        id: :default,
        variations: [
          %Variation{
            id: :default,
            slots: [~s|<.text as="p">Its a box</.text>|],
            attributes: %{}
          }
        ]
      },
      %VariationGroup{
        id: :with_borders,
        variations: [
          %Variation{
            id: :solid_border,
            attributes: %{
              background: "bg-surface",
              padding: "400",
              border_width: "025",
              border_color: "border"
            },
            slots: [~s|<.text as="p">1px solid border</.text>|]
          },
          %Variation{
            id: :dashed_border,
            attributes: %{
              background: "bg-surface",
              padding: "400",
              border_width: "025",
              borderStyle: "dashed",
              border_color: "border-secondary"
            },
            slots: [~s|<.text as="p">1px dashed border</.text>|]
          },
          %Variation{
            id: :solid_blue,
            attributes: %{
              background: "bg-surface",
              padding: "400",
              border_width: "050",
              border_color: "border-info"
            },
            slots: [~s|<.text as="p">2px solid blue</.text>|]
          },
          %Variation{
            id: :solid_yellow,
            attributes: %{
              background: "bg-surface",
              padding: "400",
              border_width: "100",
              border_color: "border-caution"
            },
            slots: [~s|<.text as="p">4px solid yellow</.text>|]
          },
          %Variation{
            id: :solid_red,
            attributes: %{
              background: "bg-surface",
              padding: "400",
              border_block_start_width: "100",
              border_color: "border-critical"
            },
            slots: [~s|<.text as="p">border-block-start: 4px solid red</.text>|]
          },
          %Variation{
            id: :small_solid_red,
            attributes: %{
              background: "bg-surface",
              padding: "400",
              border_width: "100",
              border_block_start_width: "025",
              border_color: "border-critical"
            },
            slots: [
              ~s|<.text as="p">border-width: 4px solid red</.text><.text as="p">border-block-start: 1px solid red</.text>|
            ]
          },
          %Variation{
            id: :no_inheritance,
            attributes: %{
              background: "bg-surface",
              padding: "400",
              border_width: "100",
              border_color: "border-caution"
            },
            slots: [
              ~s|<.text as="p">border-width: 4px solid yellow</.text><.text as="p" font_weight="semibold">Note: border-block-start will not inherit from the parent Box component</.text>|
            ]
          },
          %Variation{
            id: :solid_transparent,
            attributes: %{
              background: "bg-surface",
              padding: "400",
              border_width: "100",
              border_color: "transparent"
            },
            slots: [~s|<.text as="p">4px solid transparent</.text>|]
          }
        ]
      },
      %VariationGroup{
        id: :border,
        variations: [
          %Variation{
            id: :some_id,
            attributes: %{
              background: "bg-surface",
              padding: "400",
              outline_width: "025",
              outline_color: "border"
            },
            slots: [~s|<.text as="p">border</.text>|]
          },
          %Variation{
            id: :border_secondary,
            attributes: %{
              background: "bg-surface",
              padding: "400",
              outline_width: "025",
              outline_style: "dashed",
              outline_color: "border-secondary"
            },
            slots: [~s|<.text as="p">border-secondary</.text>|]
          },
          %Variation{
            id: :border_info,
            attributes: %{
              background: "bg-surface",
              padding: "400",
              outline_width: "050",
              outline_color: "border-info"
            },
            slots: [~s|<.text as="p">border-info</.text>|]
          },
          %Variation{
            id: :border_caution,
            attributes: %{
              background: "bg-surface",
              padding: "400",
              outline_width: "100",
              outline_color: "border-caution"
            },
            slots: [~s|<.text as="p">border_caution</.text>|]
          }
        ]
      },
      %VariationGroup{
        id: :border_radius,
        variations: [
          %Variation{
            id: :border_radius,
            attributes: %{background: "bg-surface", padding: "400", border_radius: "200"},
            slots: [~s|<.text as="p">border_radius</.text>|]
          }
        ]
      },
      %VariationGroup{
        id: :with_responsive_padding,
        variations: [
          %Variation{
            id: :padding_xs_200_sm_800,
            attributes: %{
              background: "bg-surface",
              padding: [xs: "200", sm: "800"],
              border_width: "025",
              border_color: "border"
            },
            slots: [~s|<.text as="p">[xs: "200", sm: "800"]</.text>|]
          },
          %Variation{
            id: :padding_block_start_xs_400_sm_1000,
            attributes: %{
              background: "bg-surface",
              padding: "200",
              padding_block_start: [xs: "400", sm: "1000"],
              border_width: "025",
              border_color: "border"
            },
            slots: [~s|<.text as="p">[xs: "400", sm: "1000"]</.text>|]
          },
          %Variation{
            id: :padding_block_end_xs_400_sm_1000,
            attributes: %{
              background: "bg-surface",
              padding: "200",
              padding_block_end: [xs: "400", sm: "1000"],
              border_width: "025",
              border_color: "border"
            },
            slots: [~s|<.text as="p">[xs: "400", sm: "1000"]</.text>|]
          },
          %Variation{
            id: :padding_inline_start_xs_400_sm_1000,
            attributes: %{
              background: "bg-surface",
              padding: "200",
              padding_inline_start: [xs: "400", sm: "1000"],
              border_width: "025",
              border_color: "border"
            },
            slots: [~s|<.text as="p">[xs: "400", sm: "1000"]</.text>|]
          },
          %Variation{
            id: :padding_inline_end_xs_400_sm_1000,
            attributes: %{
              background: "bg-surface",
              padding_inline_end: [xs: "400", sm: "1000"],
              border_width: "025",
              border_color: "border"
            },
            slots: [~s|<.text as="p">[xs: "400", sm: "1000"]</.text>|]
          }
        ]
      }
    ]
  end
end
