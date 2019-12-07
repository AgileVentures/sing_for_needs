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
alias SingForNeeds.{Artists, Causes, Performances}

Enum.each(1..100, fn number ->
  Artists.create_artist(%{name: "Awesome Artist #{number}", bio: "Awesome Artist#{number}'s bio"})
end)

Enum.each(1..10, fn number ->
  Causes.create_cause(%{
    name: "Awesome Cause #{number}",
    description: "Awesome Cause#{number}'s description",
    start_date: ~D[2019-12-31],
    end_date: ~D[2020-12-30],
    amount_raised: 4_545_76,
    target_amount: 4_545_767,
    sponsor: 'UNICEF'
  })
end)


Enum.each(1..3, fn number ->
  Performances.create_performance(%{
    title: "Awesome Performance #{number}",
    detail: "Awesome Performance#{number}'s description",
    amount_raised: 4_545_767
  })
end)
