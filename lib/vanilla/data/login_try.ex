# Tracks login attempts for a specific email address so we can block brute-force attacks.
defmodule Vanilla.Data.LoginTry do
  use Ecto.Schema
  import Ecto.Changeset

  schema "login_tries" do
    field :email, :string
    timestamps()
  end

  def admin_changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:email])
    |> validate_required([:email])
    |> downcase_field(:email)
  end

  #
  # Internal
  #

  defp downcase_field(changeset, field) do
    if value = get_change(changeset, field) do
      changeset |> put_change(field, String.downcase(value))
    else
      changeset
    end
  end
end
