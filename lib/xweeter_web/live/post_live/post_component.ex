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

        <a href="#" phx-click="like" phx-target={@myself} class="flex items-center gap-2">
          <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-thumbs-up"><path d="M7 10v12"/><path d="M15 5.88 14 10h5.83a2 2 0 0 1 1.92 2.56l-2.33 8A2 2 0 0 1 17.5 22H4a2 2 0 0 1-2-2v-8a2 2 0 0 1 2-2h2.76a2 2 0 0 0 1.79-1.11L12 2a3.13 3.13 0 0 1 3 3.88Z"/></svg>
          <span class="items-center flex"><%= @post.likes_count %></span>
        </a>

        <a href="#" phx-click="repost" phx-target={@myself} class="flex items-center gap-2">
          <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-repeat-2"><path d="m2 9 3-3 3 3"/><path d="M13 18H7a2 2 0 0 1-2-2V6"/><path d="m22 15-3 3-3-3"/><path d="M11 6h6a2 2 0 0 1 2 2v10"/></svg>
          <span class="flex items-center"><%= @post.reposts_count %></span>
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
