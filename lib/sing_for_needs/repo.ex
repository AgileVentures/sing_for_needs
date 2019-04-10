defmodule SingForNeeds.Repo do
    use Ecto.Repo,
      otp_app: :sing_for_needs,
      adapter: Ecto.Adapters.Postgres
  end
