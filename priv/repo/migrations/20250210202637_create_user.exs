defmodule Xweeter.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:user) do
      add :name, :string
      add :email, :string
      add :password, :string
      add :status, :integer

      timestamps(type: :utc_datetime)
    end
  end
end
