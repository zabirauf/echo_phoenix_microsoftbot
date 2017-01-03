defmodule EchoBot.MessagesController do
  require Logger
  use MicrosoftBot.Phoenix.Controller
  alias ExMicrosoftBot.Models.Activity
  alias ExMicrosoftBot.Client.Conversations

  def message_received(conn, %Activity{} = activity) do
    new_text = get_echo_message(activity.text)
    Logger.info "Text received: #{activity.text}"
    send_message_back(conn, activity, new_text)
  end

  defp get_echo_message(nil) do
    "ECHO: (empty)"
  end

  defp get_echo_message(text) do
    "ECHO: " <> text
  end

  defp send_message_back(conn, %Activity{} = activity, text) do
    spawn_sender(conn, activity, text)
    resp(conn, 200, "")
  end

  defp spawn_sender(_conn, %Activity{} = activity, text) do
    Logger.debug "Spawning sender"
    spawn fn ->
      Logger.debug "Going to send to #{activity.conversation.id} => #{activity.id}"
      resp = Conversations.send_to_conversation(activity.serviceUrl, activity.conversation.id, %Activity{type: "message", recipient: activity.from, from: activity.recipient, replyToId: activity.id, text: text})
      Logger.debug "......"

      Logger.debug "Response from reply_to_activity: #{inspect(resp)}"
    end
  end
end
