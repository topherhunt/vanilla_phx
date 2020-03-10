defmodule Vanilla.Helpers do
  def env!(key), do: System.get_env(key) || raise("Env var '#{key}' is missing!")
  def blank?(value), do: value == nil || (is_binary(value) && String.trim(value) == "")
  def present?(value), do: !blank?(value)
  def presence(value), do: if present?(value), do: value, else: nil
end
