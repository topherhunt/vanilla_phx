defmodule Vanilla.Helpers do

  #
  # System
  #

  def env!(key), do: System.get_env(key) || raise("Env var '#{key}' is missing!")

  def memory_mb, do: Float.round(:erlang.memory[:total] / 1_000_000.0, 3)

  #
  # Maps
  #

  def invert_map(map), do: Map.new(map, fn {k, v} -> {v, k} end)

  #
  # Lists
  #

  def intersect?(a, b), do: Enum.any?(a, & &1 in b)

  def sort(a), do: Enum.sort(a)

  #
  # Strings
  #

  def blank?(nil), do: true
  def blank?(string) when is_binary(string), do: String.trim(string) == ""

  def present?(string), do: !blank?(string)

  def presence(string), do: if present?(string), do: string, else: nil

  def capitalize_each_word(string) when is_binary(string) do
    string |> String.split() |> Enum.map(& String.capitalize(&1)) |> Enum.join(" ")
  end

  def downcase(nil), do: nil
  def downcase(string), do: String.downcase(string)

  def to_atom(nil), do: nil
  def to_atom(string), do: String.to_atom(string)

  #
  # Integers
  #

  def to_int(nil), do: nil
  def to_int(int) when is_integer(int), do: int
  def to_int(string) when is_binary(string), do: String.to_integer(string)

  #
  # Dates
  #

  def to_date(nil), do: nil
  def to_date(%DateTime{} = dt), do: DateTime.to_date(dt)

  def date_gt?(a, b), do: Date.compare(a, b) == :gt # returns true if A > B
  def date_lt?(a, b), do: Date.compare(a, b) == :lt # returns true if A < B
  def date_gte?(a, b), do: Date.compare(a, b) in [:gt, :eq] # true if A >= B
  def date_lte?(a, b), do: Date.compare(a, b) in [:lt, :eq] # true if A <= B
  def date_between?(date, a, b), do: date_gte?(date, a) && date_lte?(date, b)

  #
  # Datetimes
  #

  def datetime_gt?(a, b), do: DateTime.compare(a, b) == :gt # returns true if A > B
  def datetime_lt?(a, b), do: DateTime.compare(a, b) == :lt # returns true if A < B
  def datetime_gte?(a, b), do: DateTime.compare(a, b) in [:gt, :eq] # true if A >= B
  def datetime_lte?(a, b), do: DateTime.compare(a, b) in [:lt, :eq] # true if A <= B
  def datetime_between?(dt, a, b), do: datetime_gte?(dt, a) && datetime_lte?(dt, b)

  def beginning_of_day(%Date{} = d), do: d |> Timex.to_datetime() |> beginning_of_day()
  def beginning_of_day(%DateTime{} = dt), do: dt |> Timex.beginning_of_day()

  def end_of_day(%Date{} = d), do: d |> Timex.to_datetime() |> end_of_day()
  def end_of_day(%DateTime{} = dt), do: dt |> Timex.end_of_day()

  def hours_ago(n), do: Timex.now() |> Timex.shift(hours: -n)
  def in_hours(n), do: Timex.now() |> Timex.shift(hours: n)

  #
  # Datetime formatting
  #

  # See https://hexdocs.pm/timex/Timex.Format.DateTime.Formatters.Strftime.html
  def print_date(datetime, format \\ "%Y-%m-%d") do
    if datetime, do: Timex.format!(datetime, format, :strftime)
  end

  def print_datetime(datetime, format \\ "%Y-%m-%d %I:%M %P") do
    if datetime, do: Timex.format!(datetime, format, :strftime)
  end

end
