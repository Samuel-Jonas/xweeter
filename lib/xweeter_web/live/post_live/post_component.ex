defmodule XweeterWeb.PostLive.PostComponent do
  use XweeterWeb, :live_component

  @impl true
  def render(assigns) do
    ~H"""
    <div class="border-b pb-4 mb-4">
      <div class="flex items-center space-x-3">

        <div class="w-10 h-10 bg-gray-300 rounded-full"></div>

        <div>
          <p class="font-semibold"><%= @post.username %></p>
          <p class="text-gray-500 text-sm">@<%= String.downcase(@post.username) %></p>
        </div>
      </div>

      <p class="mt-2 text-gray-800"><%= @post.body %></p>

      <div class="flex justify-between text-gray-500 text-sm mt-3">

        <a href="#" phx-click="like" phx-target={@myself}>
          <span>👍</span>
          <span><%= @post.likes_count %></span>
        </a>

        <a href="#" phx-click="repost" phx-target={@myself}>
          <span>🔁</span>
          <span><%= @post.reposts_count %></span>
        </a>

        <.link patch={~p"/posts/#{@post}/edit"} class="text-blue-500 hover:underline">Edit</.link>

        <.link
          phx-click={JS.push("delete", value: %{id: @post.id}) |> hide("##{@id}")}
          data-confirm="Are you sure?"
          class="text-red-500 hover:underline"
        >
          Delete
        </.link>
      </div>
    </div>
    """
  end
  @impl true
  def handle_event("like", _value, socket) do
    Xweeter.Timeline.inc_like_post(socket.assigns.post)
    {:noreply, socket}
  end
  
  @impl true
  def handle_event("repost", _value, socket) do
    Xweeter.Timeline.inc_repost(socket.assigns.post)
    {:noreply, socket}
  end
end
