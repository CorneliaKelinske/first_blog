use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :the_brogrammer, TheBrogrammerWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configures Swoosh used for contact form
config :the_brogrammer, TheBrogrammer.Mailer, adapter: Swoosh.Adapters.Test
