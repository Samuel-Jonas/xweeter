defmodule XweeterWeb.UserForgotPasswordLive do
  use XweeterWeb, :live_view

  alias Xweeter.Account

  def render(assigns) do
    ~H"""
    <div class="mx-auto max-w-sm">
      <.header class="text-center">
        Esqueceu sua senha?
        <:subtitle>Nós enviaremos um link para criar uma nova senha por email.</:subtitle>
      </.header>

      <.simple_form for={@form} id="reset_password_form" phx-submit="send_email">
        <.input field={@form[:email]} type="email" placeholder="Email" required />
        <:actions>
          <.button phx-disable-with="Enviando..." class="w-full">
            Enviar link
          </.button>
        </:actions>
      </.simple_form>
      <p class="text-center text-sm mt-4">
        <.link href={~p"/user/register"}>Cadastrar-se</.link>
        | <.link href={~p"/user/log_in"}>Entrar</.link>
      </p>
    </div>
    """
  end

  def mount(_params, _session, socket) do
    {:ok, assign(socket, form: to_form(%{}, as: "user"))}
  end

  def handle_event("send_email", %{"user" => %{"email" => email}}, socket) do
    if user = Account.get_user_by_email(email) do
      Account.deliver_user_reset_password_instructions(
        user,
        &url(~p"/user/reset_password/#{&1}")
      )
    end

    info =
      "Se o seu e-mail estiver em nosso sistema, você receberá em breve instruções para redefinir sua senha."

    {:noreply,
     socket
     |> put_flash(:info, info)
     |> redirect(to: ~p"/")}
  end
end
