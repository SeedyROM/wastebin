use Mix.Config

config :wastebin, Wastebin.Repo,[
  adapter: Ecto.Adapters.Postgres,
  database: "wastebin_test_repo",
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
]