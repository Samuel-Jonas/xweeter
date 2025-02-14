defmodule Xweeter.Repo.Migrations.CreateUserAuthTables do
  use Ecto.Migration

  def change do
    execute "CREATE EXTENSION IF NOT EXISTS citext", ""

    unless table_exists?("user") do
      create table(:user) do
        add :email, :citext, null: false
        add :hashed_password, :string, null: false
        add :confirmed_at, :utc_datetime

        timestamps(type: :utc_datetime)
      end
    else
      alter table(:user) do
        add_if_not_exists :hashed_password, :string, null: false
      end
    end

    create unique_index(:user, [:email])

    unless table_exists?("user_tokens") do
      create table(:user_tokens) do
        add :user_id, references(:user, on_delete: :delete_all), null: false
        add :token, :binary, null: false
        add :context, :string, null: false
        add :sent_to, :string

        timestamps(type: :utc_datetime, updated_at: false)
      end
    end

    create index(:user_tokens, [:user_id])
    create unique_index(:user_tokens, [:context, :token])
  end

  defp table_exists?(table_name) do
    query = "SELECT to_regclass('public.#{table_name}')"
    Ecto.Adapters.SQL.query!(Xweeter.Repo, query, [])
    |> Map.get(:rows)
    |> case do
      [[nil]] -> false
      _ -> true
    end
  end

end
