# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :the_brogrammer, ecto_repos: []
# Configures the endpoint
config :the_brogrammer, TheBrogrammerWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [view: TheBrogrammerWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: TheBrogrammer.PubSub,
  live_view: [signing_salt: "n2D8haxk"]
  #secret_key_base: "BXCOcT71Lt8Tgu1KBd0YFFdoBiGd5tj/MA0VizTrCqsSFGRTY1F8oHfIr6UeAGUs"

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
