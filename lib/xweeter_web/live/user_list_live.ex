defmodule XweeterWeb.UserListLive.Index do
  use XweeterWeb, :live_view

  alias Xweeter.Account

  def mount(_params, session, socket) do
    current_user = get_current_user(session)
    users = Account.list_users()
    {:ok, assign(socket, users: users, current_user: current_user)}
  end

  def render(assigns) do
    ~L"""
    <div class="container mx-auto p-4">
      <h3 class="text-2xl font-bold mb-4">Lista de Usuários</h3>

      <div class="overflow-x-auto">
        <table class="min-w-full bg-white border border-gray-300">
          <thead>
            <tr class="bg-gray-200 text-gray-600 uppercase text-sm leading-normal">
              <th class="py-3 px-6 text-left">ID</th>
              <th class="py-3 px-6 text-left">Email</th>
            </tr>
          </thead>
          <tbody class="text-gray-600 text-sm font-light">
            <%= for user <- @users do %>
              <tr class="border-b border-gray-200 hover:bg-gray-100">
                <td class="py-3 px-6 text-left"><%= user.id %></td>
                <td class="py-3 px-6 text-left"><%= user.email %></td>
              </tr>
            <% end %>
          </tbody>
        </table>
      </div>
    </div>
    """
  end

  defp get_current_user(session) do
    case session["user_token"] do
      nil -> nil
      token -> Account.get_user_by_session_token(token)
    end
  end
end
