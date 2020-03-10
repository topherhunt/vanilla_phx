defmodule Vanilla.Repo do
  use Ecto.Repo,
    otp_app: :vanilla,
    adapter: Ecto.Adapters.Postgres
  import Ecto.Query
  alias Vanilla.Helpers, as: H

  def count(query), do: query |> select([t], count(t.id)) |> one()
  def any?(query), do: count(query) >= 1
  def first(query), do: query |> limit(1) |> one()
  def first!(query), do: query |> limit(1) |> one!()

  # Unwraps the result tuple and blows up if an error occurred.
  def unwrap!(result) do
    case result do
      {:ok, struct} -> struct
      {:error, changeset} -> raise Ecto.InvalidChangesetError, changeset: changeset
    end
  end

  # Sanitizes and casts user-submitted filters against the provided fields/types schema.
  # Returns a kwlist that can be passed to a query builder function.
  # Usage:
  #   raw = %{"date_gte" => "2020-01-18"}
  #   filters = Repo.cast_filters(raw, [date_gte: :date, name: :string])
  #   => [date_gte: ~D[2020-01-18]]
  def cast_filters(raw_filters, fields_and_types) do
    Enum.reduce(fields_and_types, [], fn({field, type}, filters) ->
      if raw_value = raw_filters |> Map.get(Atom.to_string(field)) |> H.presence() do
        filters |> Keyword.put(field, cast_value(raw_value, type))
      else
        filters
      end
    end)
  end

  defp cast_value(raw_value, type) do
    case type do
      :string -> raw_value
      :integer -> raw_value |> String.to_integer()
      :date -> raw_value |> Date.from_iso8601!()
      {:array, subtype} -> raw_value |> Enum.map(& cast_value(&1, subtype))
    end
  end

  # Assemble all this changeset's errors into a list of human-readable message.
  # e.g. ["username can't be blank", "password must be at most 20 characters"]
  def describe_errors(changeset) do
    if length(changeset.errors) == 0, do: raise "This changeset has no errors to describe!"

    changeset
    |> inject_vars_into_error_messages()
    |> Enum.map(fn({field, errors}) -> "#{field} #{Enum.join(errors, " and ")}" end)
    |> Enum.map(& String.replace(&1, "(s)", "s"))
  end

  defp inject_vars_into_error_messages(changeset) do
    Ecto.Changeset.traverse_errors(changeset, fn({msg, opts}) ->
      # e.g. input: {"must be at most %{count} chars", [count: 10, validation: ...]}
      #      output: "must be at most 3 chars"
      Enum.reduce(opts, msg, fn({key, value}, acc) ->
        String.replace(acc, "%{#{key}}", to_string(value))
      end)
    end)
  end
end
