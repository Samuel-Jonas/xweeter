defmodule Xweeter.Repo.Migrations.CreatePosts do
  use Ecto.Migration

  def change do
    unless table_exists?("posts") do
      create table(:posts) do
        add :username, :string
        add :body, :string
        add :likes_count, :integer
        add :reposts_count, :integer

        timestamps(type: :utc_datetime)
      end
    end
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
