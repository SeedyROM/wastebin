defmodule Test.CaseHelpers do
  @moduledoc """
  This module injects helpers and dependencies into a test case
  """
  @moduledoc since: "1.0.0"

  @doc """
  When using this macro the following statements
  are executed into the module.
  """
  defmacro __using__(_opts) do
    quote do
      alias Wastebin.Plugs.API
      alias Wastebin.Repo
      alias Wastebin.Entity.Paste
      
      import Test.Response
    end
  end
end