use Mix.Config

import_config "#{Mix.env}.exs"

config :wastebin, ecto_repos: [Wastebin.Repo]
