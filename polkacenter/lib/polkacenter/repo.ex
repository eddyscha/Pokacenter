defmodule Polkacenter.Repo do
  use Ecto.Repo,
    otp_app: :polkacenter,
    adapter: Ecto.Adapters.Postgres
end
