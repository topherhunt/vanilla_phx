# Usage: use Vanilla.Log, module: __MODULE__
defmodule Vanilla.Log do
  defmacro __using__([module: module]) do
    quote do
      require Logger

      defp log(level, message) do
        Logger.log(level, "#{pidstring()} #{module_name()}: #{message}")
      end

      defp module_name, do: "#{unquote(module)}" |> String.replace("Elixir.", "")

      defp pidstring, do: Regex.replace(~r/#PID<([\d\.]+)>/, inspect(self()), "\\1")
    end
  end
end
