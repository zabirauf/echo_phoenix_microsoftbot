defmodule EchoBot.Router do
  use EchoBot.Web, :router
  use MicrosoftBot.Router

  microsoftbot_routes "/api/messages", EchoBot.MessagesController
end
