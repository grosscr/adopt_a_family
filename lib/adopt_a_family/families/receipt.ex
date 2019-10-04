defmodule AdoptAFamily.Families.Receipt do
  use Ecto.Schema
  import Ecto.Changeset

  schema "receipts" do
    field :receipt, :binary

    timestamps()

    has_one(:gift, AdoptAFamily.Families.Gift)
  end

  @doc false
  def changeset(receipt, attrs) do
    receipt
    |> cast(attrs, [:receipt])
    |> validate_required([:receipt])
  end
end
