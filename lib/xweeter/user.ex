defmodule Xweeter.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "user" do
    field :name, :string
    field :status, :integer
    field :password, :string
    field :email, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :email, :password, :status])
    |> validate_required([:name, :email, :password, :status])
  end
end
