defmodule AdoptAFamily.Gifts.FamilyGift do
  use Ecto.Schema
  import Ecto.Changeset

  schema "family_gifts" do
    field :item, :string
    field :price, :decimal
    field :purchased, :boolean, default: false
    field :via_paypal, :boolean, default: false

    timestamps()

    belongs_to(:family, AdoptAFamily.Gifts.Family)
    belongs_to(:user, AdoptAFamily.Accounts.User, foreign_key: :purchaser_id)
    belongs_to(:receipt, AdoptAFamily.Gifts.Receipt)
  end

  @doc false
  def changeset(family_gift, attrs) do
    family_gift
    |> cast(attrs, [:item, :purchaser_id, :price, :via_paypal, :receipt_id, :family_id, :purchased])
    |> validate_required([:item, :family_id])
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
