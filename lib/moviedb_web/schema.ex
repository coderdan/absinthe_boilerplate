defmodule MoviedbWeb.Schema do
  use Absinthe.Schema

  @movies %{
    "1" => %{title: "Star Wars"},
    "2" => %{title: "Godzilla"},
  }

  @desc "A Movie"
  object :movie do
    @desc "The Movie's title at release time"
    field :title, :string do
      resolve fn _, _, _ ->
        {:error, "No title"}
      end
    end
  end

  query do
    @desc "Look up a movie by its ID"
    field :movie, :movie do
      @desc "The unique ID of the movie"
      arg :id, non_null(:id)

      resolve fn %{id: id} = _args, _resolution ->
        {:ok, Map.get(@movies, id)}
      end
    end
  end
end
