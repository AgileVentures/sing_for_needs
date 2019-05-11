defmodule SingForNeedsWeb.Schema.Schema do
    use Absinthe.Schema

    query do
      @desc "get list of artists"
      field :artists, list_of(:artist) do       
      end       
    end

    object :artist do      
    end
end