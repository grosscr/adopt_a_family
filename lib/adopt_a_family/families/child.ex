defmodule AdoptAFamily.Families.Child do
  use Ecto.Schema
  import Ecto.Changeset

  schema "children" do
    field :age, :integer
    field :gender, :string
    field :interests, :string
    field :name, :string

    timestamps()

    belongs_to(:family, AdoptAFamily.Families.Family)
    has_many(:gifts, AdoptAFamily.Families.Gift)
  end

  @doc false
  def changeset(child, attrs) do
    child
    |> cast(attrs, [:name, :gender, :age, :interests, :family_id])
    |> validate_required([:name, :gender, :age, :family_id])
    |> validate_number(:age, greater_than: 0)
    |> validate_inclusion(:gender, ["male", "female"])
  end
end
