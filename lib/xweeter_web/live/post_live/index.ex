defmodule XweeterWeb.PostLive.Index do
  use XweeterWeb, :live_view

  alias Xweeter.Timeline
  alias Xweeter.Timeline.Post

  @impl true
  def mount(_params, session, socket) do
    if connected?(socket), do: Timeline.subscribe()

    current_user = get_current_user_from_session(session)

    socket =
      socket
      |> assign(:current_user, current_user)
      |> assign(:posts, fetch_posts())

    {:ok, stream(socket, :posts, fetch_posts())}
  end

  defp get_current_user_from_session(session) do
    if token = session["user_token"] do
      Xweeter.Account.get_user_by_session_token(token)
    else
      nil
    end
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Post")
    |> assign(:post, Timeline.get_post!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Post")
    |> assign(:post, %Post{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Feed")
    |> assign(:post, nil)
  end

  @impl true
  def handle_info({XweeterWeb.PostLive.FormComponent, {:saved, _post}}, socket) do
    posts = fetch_posts()
    {:noreply, stream(socket, :posts, posts)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    post = Timeline.get_post!(id)
    {:ok, _} = Timeline.delete_post(post)

    posts = fetch_posts()
    {:noreply, stream(socket, :posts, posts)}
  end

  @impl true
  def handle_info({:post_created, _post}, socket) do
    posts = fetch_posts()
    {:noreply, stream(socket, :posts, posts)}
  end

  @impl true
  def handle_info({:post_updated, _post}, socket) do
    posts = fetch_posts()
    {:noreply, stream(socket, :posts, posts)}
  end

  def fetch_posts do
    Timeline.list_posts()
  end
end
