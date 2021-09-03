# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :first_blog,
  ecto_repos: [FirstBlog.Repo]

# Configures the endpoint
config :first_blog, FirstBlogWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "YySRmPNSQFs7FHKRaHJ42fwUklRwn9NYEZr+nZEwnDAz2ygMu0oSo8Nc08QwHC1R",
  render_errors: [view: FirstBlogWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: FirstBlog.PubSub,
  live_view: [signing_salt: "n2D8haxk"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

#Configures Swoosh used for contact form
config :first_blog, FirstBlog.Mailer,
adapter: Swoosh.Adapters.Test




# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
