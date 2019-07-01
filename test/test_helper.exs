# Start ExUnit
ExUnit.start()

# Setup Ecto in sandbox mode
Ecto.Adapters.SQL.Sandbox.mode(Wastebin.Repo, :manual)

# Load helper modules
helpers = Path.wildcard("./test/helpers/**/*.ex")
Enum.map(helpers, &Code.load_file(&1))