defmodule XweeterWeb.PostLive.Show do
  use XweeterWeb, :live_view

  alias Xweeter.Timeline

  @impl true
  def mount(_params, session, socket) do
    if connected?(socket), do: Timeline.subscribe()

    current_user = get_current_user_from_session(session)

    socket =
      socket
      |> assign(:current_user, current_user)

    {:ok, socket}
  end

  defp get_current_user_from_session(session) do
    if token = session["user_token"] do
      Xweeter.Account.get_user_by_session_token(token)
    else
      nil
    end
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:post, Timeline.get_post!(id))}
  end

  defp page_title(:show), do: "Show Post"
  defp page_title(:edit), do: "Edit Post"
end
