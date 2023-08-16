# Each Nonce is a unique numeric ID that can be used to make single-use tokens.
# Note that the nonce is persisted, but the signed token itself is stateless,
# and includes the nonce's id along with the data payload.
defmodule Vanilla.Data.Nonce do
  use Ecto.Schema
  import Ecto.Changeset

  schema "nonces" do
    timestamps()
  end

  def admin_changeset(struct, params \\ %{}) do
    struct |> cast(params, [])
  end
end
