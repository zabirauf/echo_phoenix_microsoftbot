defmodule EchoBot.MessagesController do
  use MicrosoftBot.Phoenix.Controller
  alias ExMicrosoftBot.Models.Message
  alias ExMicrosoftBot.Client

  def message_received(conn, %Message{} = message) do
    {new_text, is_delayed} = get_echo_message(message.text)
    send_message_back(conn, message, new_text, is_delayed)
  end

  defp get_echo_message(nil) do
    {"ECHO: (empty)", false}
  end

  defp get_echo_message("delayed " <> _ = text) do
    {"ECHO: " <> text, true}
  end

  defp get_echo_message(text) do
    {"ECHO: " <> text, false}
  end

  defp send_message_back(conn, %Message{} = message, text, true) do
    spawn_sender(conn, message, text)
    resp(conn, 200, "")
  end

  defp send_message_back(_conn, %Message{} = _, text, false) do
    %{text: text}
  end

  defp spawn_sender(_conn, %Message{} = message, text) do
    spawn fn ->
      :timer.sleep(5000) # Wait for 5 seconds
      get_bot_auth_data
      |> Client.send_message(%{to: message.from, from: message.to, replyToMessageId: message.id, text: "DELAYED -> " <> text})
    end
  end

  defp get_bot_auth_data() do
    %ExMicrosoftBot.Models.AuthData{
      app_id: Application.get_env(:microsoftbot, :app_id),
      app_secret: Application.get_env(:microsoftbot, :app_secret)
    }
  end
end
