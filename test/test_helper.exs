ExUnit.start()
Faker.start()

Ecto.Adapters.SQL.Sandbox.mode(SingForNeeds.Repo, {:shared, self()})

{:ok, _} = Application.ensure_all_started(:ex_machina)
