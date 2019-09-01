defmodule AdoptAFamily.Gifts.Family do
  use Ecto.Schema
  import Ecto.Changeset

  schema "families" do
    field :clinician, :string
    field :head_of_house, :string

    timestamps()
  end

  @doc false
  def changeset(family, attrs) do
    family
    |> cast(attrs, [:head_of_house, :clinician])
    |> validate_required([:head_of_house, :clinician])
  end
end
