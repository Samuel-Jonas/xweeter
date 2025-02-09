defmodule Xweeter.Repo do
  use Ecto.Repo,
    otp_app: :xweeter,
    adapter: Ecto.Adapters.Postgres
end
