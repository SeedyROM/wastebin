defmodule Wastebin.Helpers.JSONRouter do
  defmacro __using__(_opts) do
    quote do
      use Plug.Router

      plug Plug.Parsers, parsers: [:json],
        pass:  ["application/json"],
        json_decoder: Poison

      plug :match
      plug :dispatch
    end
  end
end