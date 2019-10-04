defmodule AdoptAFamily.Families.GiftTest do
  use AdoptAFamily.DataCase
  alias AdoptAFamily.Families.Gift
  alias Ecto.Changeset

  describe "changeset/2" do
    setup do
      valid_attrs = %{
        item: "Present",
        child_id: 1
      }
      %{attrs: valid_attrs}
    end

    def get_changeset(attrs) do
      Gift.changeset(%Gift{}, attrs)
    end

    test "valid data creates a valid changeset", %{attrs: attrs} do
      assert %Changeset{} = changeset = get_changeset(attrs)
      assert changeset.valid?
    end

    test "missing required params creates an invalid changeset" do
      assert %Ecto.Changeset{} = changeset = get_changeset(%{})
      refute changeset.valid?
      assert Keyword.keys(changeset.errors) == [:item, :child_id]
    end

    test "invalid price creates an invalid changeset", %{attrs: attrs} do
      assert %Ecto.Changeset{} = changeset = get_changeset(Map.put(attrs, :price, 0))
      refute changeset.valid?
      assert Keyword.keys(changeset.errors) == [:price]
    end

    test "requires receipt with paypal", %{attrs: attrs} do
      assert %Ecto.Changeset{} = changeset = get_changeset(Map.put(attrs, :via_paypal, true))
      refute changeset.valid?
      assert Keyword.keys(changeset.errors) == [:receipt_id]
    end
  end
end
