use Mix.Config

# In this file, we keep production configuration that
# you'll likely want to automate and keep away from
# your version control system.
#
# You should document the content of this
# file or create a script for recreating it, since it's
# kept out of version control and might be hard to recover
# or recreate for your teammates (or yourself later on).
config :gotham, GothamWeb.Endpoint,
  secret_key_base: "yhw5dbFaXSBGgJaNRzCCs8rHQpTk7mauPbBChmQ76mYfOCliyT2+7rMGK4fIrMQx"

# Configure your database
config :gotham, Gotham.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "gotham_prod",
  pool_size: 15
