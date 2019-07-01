defmodule Wastebin.MixProject do
  use Mix.Project

  def project do
    [
      app: :wastebin,
      version: "0.1.0",
      elixir: "~> 1.8",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      elixirc_path: compiler_paths(Mix.env())
    ]
  end

  def compiler_paths(:test), do: ["test/helpers"] ++ compiler_paths(:prod)
  def compiler_paths(_), do: ["lib"]


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
      {:poison, "~> 3.1"},
    ]
  end
end
