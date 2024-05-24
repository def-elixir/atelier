import Config

config :atelier, ecto_repos: [Atelier.Repo]

config :atelier, Atelier.Repo,
  database: Path.expand("../data/atelier_repo.db", Path.dirname(__ENV__.file)),
  pool_size: 5,
  stacktrace: true,
  show_sensitive_data_on_connection_error: true
