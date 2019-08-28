defmodule AdoptAFamily.Repo do
  use Ecto.Repo,
    otp_app: :adopt_a_family,
    adapter: Ecto.Adapters.Postgres
end
