# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     SingForNeeds.Repo.insert!(%SingForNeeds.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias SingForNeeds.Artists

(1..100)
  |>Enum.each(fn (number) -> Artists.create_artist(%{name: "Awesome Artist #{number}"}) end)
