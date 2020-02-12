defmodule VanillaWeb.FormHelpers do
  import VanillaWeb.Gettext

  def required do
    Phoenix.HTML.raw " <span class='text-danger u-tooltip-target'>*<div class='u-tooltip'>#{gettext("Required")}</div></span>"
  end
end
