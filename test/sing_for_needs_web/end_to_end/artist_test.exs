defmodule SingForNeeds.ArtistTest do
  use ExUnit.Case
  # import HTTPoison

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(SingForNeeds.Repo)
  end

  test "creates an artist" do
    HTTPoison.post!('artist', "")
  end
end
