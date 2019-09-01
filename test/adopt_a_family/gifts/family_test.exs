defmodule AdoptAFamily.Gifts.FamilyTest do
  use AdoptAFamily.DataCase
  alias AdoptAFamily.Gifts.Family
  alias Ecto.Changeset

  describe "changeset/2" do
    def get_changeset(attrs) do
      Family.changeset(%Family{}, attrs)
    end

    test "valid data creates a valid changeset" do
      attrs = %{head_of_house: "Head", clinician: "Clinician"}
      assert %Changeset{} = changeset = get_changeset(attrs)
      assert changeset.valid?
    end

    test "missing required params creates an invalid changeset" do
      assert %Ecto.Changeset{} = changeset = get_changeset(%{})
      refute changeset.valid?
      assert Keyword.keys(changeset.errors) == [:head_of_house, :clinician]
    end
  end
end
