defmodule VanillaWeb.MiscHelpers do
  import VanillaWeb.Gettext

  def required do
    Phoenix.HTML.raw " <span class='text-danger u-tooltip-target'>*<div class='u-tooltip'>#{gettext("Required")}</div></span>"
  end

  def if_path(conn, substring, result) do
    if String.contains?(conn.request_path, substring), do: result
  end

  # See icons.scss
  def icon(type, text \\ "") do
    Phoenix.HTML.raw "<i class='icon'>#{type}</i> #{text}"
  end
end
