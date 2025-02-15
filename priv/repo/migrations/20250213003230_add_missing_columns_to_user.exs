defmodule Xweeter.Repo.Migrations.AddMissingColumnsToUser do
  use Ecto.Migration

  def change do
    alter table(:user) do
      add_if_not_exists :email, :citext, null: false
      add_if_not_exists :hashed_password, :string, null: false
      add_if_not_exists :confirmed_at, :utc_datetime
    end

    create_if_not_exists unique_index(:user, [:email])
  end
end
