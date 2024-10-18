defmodule Plugmap do
  @moduledoc """

  """

  @doc false
  defmacro __using__(opts) do
    quote do
      use Plugmap.DSL, unquote(opts)
    end
  end
end
