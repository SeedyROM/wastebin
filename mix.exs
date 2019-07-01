defmodule Wastebin.MixProject do
  use Mix.Project

  def project do
    [
      app: :wastebin,
      version: "0.1.0",
      elixir: "~> 1.8",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger],
      mod: {Wastebin.Application, []}
    ]
  end

  defp deps do
    [
      {:plug_cowboy, "~> 2.0"},
      {:ecto, "~> 2.0"},
      {:postgrex, "~> 0.11"},
    ]
  end
end
