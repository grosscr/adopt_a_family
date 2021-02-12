defmodule AdoptAFamily.Families.Family do
  use Ecto.Schema
  import Ecto.Changeset

  schema "families" do
    field :clinician, :string
    field :head_of_house, :string

    timestamps()

    has_many(:children, AdoptAFamily.Families.Child)
    has_many(:family_gifts, AdoptAFamily.Families.FamilyGift)
  end

  @doc false
  def changeset(family, attrs) do
    family
    |> cast(attrs, [:head_of_house, :clinician])
    |> cast_assoc(:children)
    |> validate_required([:head_of_house, :clinician])
  end
end
