defmodule VanillaWeb do
  @moduledoc """
  The entrypoint for defining your web interface, such
  as controllers, views, channels and so on.

  This can be used in your application as:

      use VanillaWeb, :controller
      use VanillaWeb, :view

  The definitions below will be executed for every view,
  controller, etc, so keep them short and clean, focused
  on imports, uses and aliases.

  Do NOT define functions inside the quoted expressions
  below. Instead, define any helper function in modules
  and import those modules here.
  """

  def controller do
    quote do
      use Phoenix.Controller, namespace: VanillaWeb

      import Plug.Conn
      import Phoenix.LiveView.Controller
      import VanillaWeb.Gettext
      import VanillaWeb.SentryPlugs
      alias VanillaWeb.Router.Helpers, as: Routes
      alias Vanilla.Repo
    end
  end

  def view do
    quote do
      use Phoenix.View, root: "lib/vanilla_web/templates", namespace: VanillaWeb

      import Phoenix.Controller,
        only: [get_flash: 1, get_flash: 2, view_module: 1, view_template: 1]

      # Include shared imports and aliases for views
      unquote(view_helpers())
    end
  end

  # See https://hexdocs.pm/phoenix_live_view/installation.html#phx-gen-live-support
  def live_view do
    quote do
      use Phoenix.LiveView, layout: {VanillaWeb.LayoutView, "live.html"}

      # Include shared imports and aliases for views
      unquote(view_helpers())
    end
  end

  def live_component do
    quote do
      use Phoenix.LiveComponent

      # Include shared imports and aliases for views
      unquote(view_helpers())
    end
  end

  def router do
    quote do
      use Phoenix.Router
      import Plug.Conn
      import Phoenix.Controller
      import Phoenix.LiveView.Router
    end
  end

  def channel do
    quote do
      use Phoenix.Channel
      import VanillaWeb.Gettext
    end
  end

  # Shared imports & aliases for views
  defp view_helpers do
    quote do
      use Phoenix.HTML # Use all HTML functionality (forms, tags, etc)
      import Phoenix.LiveView.Helpers # live_render, live_component, live_patch, etc.
      import Phoenix.View # Basic rendering functionality (render, render_layout, etc)
      import VanillaWeb.ErrorHelpers
      import VanillaWeb.FormHelpers
      import VanillaWeb.Gettext
      alias VanillaWeb.Router.Helpers, as: Routes
    end
  end

  @doc """
  When used, dispatch to the appropriate controller/view/etc.
  """
  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end
