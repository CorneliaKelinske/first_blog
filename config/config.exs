# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :first_blog, ecto_repos: []
# Configures the endpoint
config :first_blog, FirstBlogWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [view: FirstBlogWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: FirstBlog.PubSub,
  live_view: [signing_salt: "n2D8haxk"],
  secret_key_base: "BXCOcT71Lt8Tgu1KBd0YFFdoBiGd5tj/MA0VizTrCqsSFGRTY1F8oHfIr6UeAGUs"

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :recaptcha,
  secret: "6LeIxAcTAAAAAGG-vFI1TnRWxMZNFuojJ4WifJWe",
  json_library: Jason

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
