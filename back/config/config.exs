# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :gotham,
  ecto_repos: [Gotham.Repo]

# Configures the endpoint
config :gotham, GothamWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "kpZQAnZvvBO2gWZ7Cxth14kcsc6nkSeUh/VwtzkGmAx4BnjpKo4pSaKn8MH1oz00",
  render_errors: [view: GothamWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Gotham.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
