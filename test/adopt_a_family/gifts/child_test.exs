defmodule AdoptAFamily.Gifts.ChildTest do
  use AdoptAFamily.DataCase
  alias AdoptAFamily.Gifts.Child
  alias Ecto.Changeset

  describe "changeset/2" do
    setup do
      {:ok, family} = %AdoptAFamily.Gifts.Family{}
                      |> AdoptAFamily.Gifts.Family.changeset(%{
                        head_of_house: "Head",
                        clinician: "Clinician"
                      })
                      |> Repo.insert()
      valid_attrs = %{
        name: "John Doe",
        gender: "male",
        age: 10,
        family_id: family.id
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
