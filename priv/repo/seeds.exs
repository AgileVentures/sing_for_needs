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

Enum.each((1..100), fn (number) -> Artists.create_artist(%{name: "Awesome Artist #{number}", bio: "Awesome Artist#{number}'s bio"}) end)
