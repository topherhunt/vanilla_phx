defmodule ExpensesWeb.Router do
  use ExpensesWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", ExpensesWeb do
    pipe_through :browser

    # In dev, preview all "sent" emails at localhost:4000/sent_emails
    if Mix.env == :dev do
      forward "/sent_emails", Bamboo.SentEmailViewerPlug
    end

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", ExpensesWeb do
  #   pipe_through :api
  # end
end
