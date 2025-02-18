defmodule XweeterWeb.UserSessionController do
  use XweeterWeb, :controller

  alias Xweeter.Account
  alias XweeterWeb.UserAuth

  def create(conn, %{"_action" => "registered"} = params) do
    create(conn, params, "Conta criada com sucesso!")
  end

  def create(conn, %{"_action" => "password_updated"} = params) do
    conn
    |> put_session(:user_return_to, ~p"/user/settings")
    |> create(params, "Senha atualizada com sucesso!")
  end

  def create(conn, params) do
    create(conn, params, "Bem vindo de volta!")
  end

  defp create(conn, %{"user" => user_params}, info) do
    %{"email" => email, "password" => password} = user_params

    if user = Account.get_user_by_email_and_password(email, password) do
      conn
      |> put_flash(:info, info)
      |> UserAuth.log_in_user(user, user_params)
    else
      # In order to prevent user enumeration attacks, don't disclose whether the email is registered.
      conn
      |> put_flash(:error, "Email ou senha inválidos")
      |> put_flash(:email, String.slice(email, 0, 160))
      |> redirect(to: ~p"/user/log_in")
    end
  end

  def delete(conn, _params) do
    conn
    |> put_flash(:info, "Você saiu com sucesso.")
    |> UserAuth.log_out_user()
  end
end
