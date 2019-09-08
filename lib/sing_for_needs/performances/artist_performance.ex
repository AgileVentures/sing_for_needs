defmodule SingForNeeds.Performances.ArtistPerformance do
    @moduledoc """
        Links performances and atrists
    """
      use Ecto.Schema
      import Ecto.Changeset
      alias SingForNeeds.Artists.Artist
      alias SingForNeeds.Performances.Performance

      schema "artists_performances" do
        belongs_to :artists, Artist
        belongs_to :performances, Performance

        timestamps()
      end
end
