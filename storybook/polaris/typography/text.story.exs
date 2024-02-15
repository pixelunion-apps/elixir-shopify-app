defmodule Storybook.PolarisComponents.Text do
  use PhoenixStorybook.Story, :component

  def function, do: &ShopifyAppWeb.ShopAdmin.PolarisComponents.Text.text/1

  def variations do
    [
      %VariationGroup{
        id: :heading,
        variations: [
          %Variation{
            id: :h2,
            slots: ["Online store dashboard"],
            attributes: %{
              variant: "heading3xl",
              as: "h2"
            }
          },
          %Variation{
            id: :h3,
            slots: ["Online store dashboard"],
            attributes: %{
              variant: "heading2xl",
              as: "h3"
            }
          },
          %Variation{
            id: :h4,
            slots: ["Online store dashboard"],
            attributes: %{
              variant: "headingXl",
              as: "h4"
            }
          },
          %Variation{
            id: :h5,
            slots: ["Online store dashboard"],
            attributes: %{
              variant: "headingLg",
              as: "h5"
            }
          },
          %Variation{
            id: :h6,
            slots: ["Online store dashboard"],
            attributes: %{
              variant: "headingMd",
              as: "h6"
            }
          },
          %Variation{
            id: :h6sm,
            slots: ["Online store dashboard"],
            attributes: %{
              variant: "headingSm",
              as: "h6"
            }
          }
        ]
      },
      %VariationGroup{
        id: :body,
        variations: [
          %Variation{
            id: :bodyLg,
            slots: [
              "Shopify POS is the easiest way to sell your products in person. Available for iPad, iPhone, and Android."
            ],
            attributes: %{
              variant: "bodyLg",
              as: "p"
            }
          },
          %Variation{
            id: :h3,
            slots: [
              "Shopify POS is the easiest way to sell your products in person. Available for iPad, iPhone, and Android."
            ],
            attributes: %{
              variant: "bodySm",
              as: "p"
            }
          }
        ]
      },
      %VariationGroup{
        id: :align,
        variations: [
          %Variation{
            id: :start,
            slots: [
              "Manage your Shopify store on-the-go with real-time notifications, access to your dashboard, and order management, all from your smartphone."
            ],
            attributes: %{
              variant: "bodyLg",
              as: "p",
              alignment: "start"
            }
          },
          %Variation{
            id: :center,
            slots: [
              "Manage your Shopify store on-the-go with real-time notifications, access to your dashboard, and order management, all from your smartphone."
            ],
            attributes: %{
              variant: "bodyLg",
              as: "p",
              alignment: "center"
            }
          },
          %Variation{
            id: :end,
            slots: [
              "Manage your Shopify store on-the-go with real-time notifications, access to your dashboard, and order management, all from your smartphone."
            ],
            attributes: %{
              variant: "bodyLg",
              as: "p",
              alignment: "end"
            }
          },
          %Variation{
            id: :justify,
            slots: [
              " Manage your Shopify store on-the-go with real-time notifications, access to your dashboard, and order management, all from your smartphone."
            ],
            attributes: %{
              variant: "bodyLg",
              as: "p",
              alignment: "justify"
            }
          }
        ]
      },
      %VariationGroup{
        id: :weight,
        variations: [
          %Variation{
            id: :bold,
            slots: ["Sales this year"],
            attributes: %{
              font_weight: "bold",
              as: "p"
            }
          },
          %Variation{
            id: :semibold,
            slots: ["Sales this year"],
            attributes: %{
              font_weight: "semibold",
              as: "p"
            }
          },
          %Variation{
            id: :medium,
            slots: ["Sales this year"],
            attributes: %{
              font_weight: "medium",
              as: "p"
            }
          },
          %Variation{
            id: :regular,
            slots: ["Sales this year"],
            attributes: %{
              font_weight: "regular",
              as: "p"
            }
          }
        ]
      },
      %VariationGroup{
        id: :tone,
        variations: [
          %Variation{
            id: :subdued,
            slots: ["Use to de-emphasize a piece of text that is less important to merchants
                    than other nearby text. May also be used to indicate when normal content
                    is absent, for example, “No supplier listed”. Don’t use only for
                    aesthetic effect."],
            attributes: %{
              tone: "subdued",
              as: "p"
            }
          },
          %Variation{
            id: :success,
            slots: ["Use in combination with a symbol showing an increasing value to indicate
                    an upward trend."],
            attributes: %{
              tone: "success",
              as: "p"
            }
          },
          %Variation{
            id: :caution,
            slots: ["Use to denote something that needs attention, or that merchants need to
                    take action on."],
            attributes: %{
              tone: "caution",
              as: "p"
            }
          },
          %Variation{
            id: :critical,
            slots: ["Use in combination with a symbol showing a decreasing value to indicate
                    a downward trend."],
            attributes: %{
              tone: "critical",
              as: "p"
            }
          }
        ]
      },
      %VariationGroup{
        id: :decoration,
        variations: [
          %Variation{
            id: :subdued,
            slots: ["$100.00"],
            attributes: %{
              text_decoration_line: "line-through",
              as: "p"
            }
          }
        ]
      }
    ]
  end
end
