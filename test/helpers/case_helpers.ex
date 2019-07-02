defmodule Test.CaseHelpers do
  defmacro __using__(_opts) do
    quote do
      alias Wastebin.Plugs.API
      alias Wastebin.Repo
      alias Wastebin.Entity.Paste
      
      import Test.Response
    end
  end
end