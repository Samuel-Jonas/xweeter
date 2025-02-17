defmodule Xweeter.Repo.Migrations.AddUsernameToUser do
  use Ecto.Migration

  def change do
    alter table(:user) do
      add :username, :string
    end
  end
end
