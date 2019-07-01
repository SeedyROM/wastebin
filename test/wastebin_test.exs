defmodule WastebinTest do
  use ExUnit.Case
  doctest Wastebin

  test "greets the world" do
    assert Wastebin.hello() == :world
  end
end
