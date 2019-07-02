defmodule Wastebin.Helpers.Repo do
  defmacro __using__(_opts) do
    quote do
      alias Wastebin.Repo
      alias Wastebin.Entity.Paste
    end
  end
end