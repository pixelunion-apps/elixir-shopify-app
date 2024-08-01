defmodule ShopifyApp.Schema do
  defmacro __using__(args) do
    quote do
      use Ecto.Schema

      case Keyword.get(unquote(args), :id_type, :binary_id) do
        :binary_id ->
          @primary_key {:id, :binary_id, autogenerate: true}
          @foreign_key_type :binary_id

        :id ->
          @primary_key {:id, :id, autogenerate: true}
          @foreign_key_type :id

        other ->
          raise("unsupported id type, #{inspect(other)}")
      end

      @derive {Phoenix.Param, key: :id}
    end
  end
end
