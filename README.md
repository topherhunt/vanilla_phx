# Vanilla Phoenix app

This app was built by following the steps in `doc/howto_rebuild.md`. Last built 2020-02-12.

How to branch a new app based on this vanilla template:

  * `git clone git@github.com:topherhunt/vanilla_phx.git my_folder_name`
  * `cd my_folder_name`
  * find & replace all uses of "Vanilla" and "vanilla" with your app's name
  * rename folders & files in lib/ and test/ as above
  * Create secrets.exs from secrets.exs.template. Fill it in as relevant.
  * `mix deps.get`
  * `mix ecto.create`
  * `mix ecto.migrate`
  * `mix test` - around 30 tests should run; all should pass
