defmodule AdoptAFamily.Families.Gift do
  use Ecto.Schema
  import Ecto.Changeset

  schema "gifts" do
    field :item, :string
    field :price, :decimal
    field :shipped, :boolean, default: false
    field :size, :string
    field :via_paypal, :boolean, default: false

    timestamps()

    belongs_to(:child, AdoptAFamily.Families.Child)
    belongs_to(:purchaser, AdoptAFamily.Accounts.User, foreign_key: :purchaser_id)
    belongs_to(:receipt, AdoptAFamily.Families.Receipt)
  end

  @doc false
  def changeset(gift, attrs) do
    gift
    |> cast(attrs, [:item, :size, :purchaser_id, :price, :via_paypal, :receipt_id, :child_id, :shipped])
    |> validate_required([:item])
    |> validate_number(:price, greater_than: 0)
    |> validate_receipt_if_paypal()
  end

  def validate_receipt_if_paypal(changeset) do
    validate_change(changeset, :via_paypal, fn(_current_field, value) ->
      do_validate_receipt_if_paypal(value, Map.get(changeset.changes, :receipt_id))
    end)
  end

  defp do_validate_receipt_if_paypal(true, nil) do
    [{:receipt_id, "Receipt required if purchased via PayPal pool"}]
  end
  defp do_validate_receipt_if_paypal(_, _), do: []
end
