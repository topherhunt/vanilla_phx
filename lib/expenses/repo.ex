defmodule Expenses.Repo do
  use Ecto.Repo,
    otp_app: :expenses,
    adapter: Ecto.Adapters.Postgres
end
