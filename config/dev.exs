use Mix.Config

config :wastebin, Wastebin.Repo,
  adapter: Ecto.Adapters.Postgres,
  database: "wastebin_repo",
  username: "postgres",
  password: "postgres",
  hostname: "localhost"