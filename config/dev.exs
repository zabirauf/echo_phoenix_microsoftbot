use Mix.Config

# For development, we disable any cache and enable
# debugging and code reloading.
#
# The watchers configuration can be used to run external
# watchers to your application. For example, we use it
# with brunch.io to recompile .js and .css sources.
config :echo_bot, EchoBot.Endpoint,
  http: [port: 4000],
  debug_errors: true,
  code_reloader: true,
  check_origin: false,
  watchers: []

# Do not include metadata nor timestamps in development logs
config :logger, :console, format: "[$level] $message\n"

# Set a higher stacktrace during development.
# Do not configure such in production as keeping
# and calculating stacktraces is usually expensive.
config :phoenix, :stacktrace_depth, 20

config :ex_microsoftbot,
  endpoint: "http://localhost:9000",
  openid_valid_keys_url: "https://login.microsoftonline.com/common/v2.0/.well-known/openid-configuration",
  issuer_claim: "https://sts.windows.net/72f988bf-86f1-41af-91ab-2d7cd011db47/",
  audience_claim: "https://graph.microsoft.com",
  bot_emulator_extra_validation: true

