defmodule ShopifyApp.Plug.CORS do
  @moduledoc """
  Allows CORS for the specific path.

  # Example

    plug ShopifyApp.Plug.CORS, path: "shop_admin"
  """

  @cors CORSPlug.init(origin: ["*"])

  def init(opts), do: Keyword.fetch!(opts, :path)

  def call(%Plug.Conn{path_info: [path | _]} = conn, path), do: CORSPlug.call(conn, @cors)
  def call(conn, _opts), do: conn
end
