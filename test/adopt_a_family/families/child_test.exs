defmodule AdoptAFamily.Families.ChildTest do
  use AdoptAFamily.DataCase
  alias AdoptAFamily.Families.Child
  alias Ecto.Changeset

  describe "changeset/2" do
    setup do
      valid_attrs = %{
        name: "John Doe",
        gender: "male",
        age: 10,
        family_id: 1
      }
      %{attrs: valid_attrs}
    end

    def get_changeset(attrs) do
      Child.changeset(%Child{}, attrs)
    end

    test "valid data creates a valid changeset", %{attrs: attrs} do
      assert %Changeset{} = changeset = get_changeset(attrs)
      assert changeset.valid?
    end

    test "missing required params creates an invalid changeset" do
      assert %Ecto.Changeset{} = changeset = get_changeset(%{})
      refute changeset.valid?
      assert Keyword.keys(changeset.errors) == [:name, :gender, :age, :family_id]
    end

    test "invalid age creates an invalid changeset", %{attrs: attrs} do
      assert %Ecto.Changeset{} = changeset = get_changeset(Map.put(attrs, :age, 0))
      refute changeset.valid?
      assert Keyword.keys(changeset.errors) == [:age]
    end

    test "invalid gender creates an invalid changeset", %{attrs: attrs} do
      assert %Ecto.Changeset{} = changeset = get_changeset(Map.put(attrs, :gender, "dog"))
      refute changeset.valid?
      assert Keyword.keys(changeset.errors) == [:gender]
    end
  end
end
