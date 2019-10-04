defmodule AdoptAFamily.Families.ReceiptTest do
  use AdoptAFamily.DataCase
  alias AdoptAFamily.Families.Receipt
  alias Ecto.Changeset

  describe "changeset/2" do
    def get_changeset(attrs) do
      Receipt.changeset(%Receipt{}, attrs)
    end

    test "valid data creates a valid changeset" do
      attrs = %{receipt: "data"}
      assert %Changeset{} = changeset = get_changeset(attrs)
      assert changeset.valid?
    end

    test "missing required params creates an invalid changeset" do
      assert %Ecto.Changeset{} = changeset = get_changeset(%{})
      refute changeset.valid?
      assert Keyword.keys(changeset.errors) == [:receipt]
    end
  end
end
