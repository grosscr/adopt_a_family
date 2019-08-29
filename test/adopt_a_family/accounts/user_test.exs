defmodule AdoptAFamily.Accounts.UserTest do
  use AdoptAFamily.DataCase

  alias AdoptAFamily.Accounts.User
  alias Ecto.Changeset

  setup do
    %{
      attrs: %{
        email: "email@test.com",
        password: "password", password_confirmation: "password",
        name: "some name",
        username: "username"
      }
    }
  end

  describe "changeset/2" do

    def get_changeset(attrs) do
      User.changeset(%User{}, attrs)
    end

    test "valid data creates a valid changeset", %{attrs: attrs} do
      assert %Changeset{} = changeset = get_changeset(attrs)
      assert changeset.valid?
    end

    test "missing required params creates an invalid changeset" do
      assert %Ecto.Changeset{} = changeset = get_changeset(%{})
      refute changeset.valid?
      assert Keyword.keys(changeset.errors) == [:email, :username, :password, :password_confirmation]
    end

    test "changeset encrypts the password", %{attrs: attrs} do
      assert %Changeset{} = changeset = get_changeset(attrs)
      assert Bcrypt.check_pass(changeset.changes, attrs.password)
    end

    test "create_user/1 downcases username", %{attrs: attrs} do
      assert %Changeset{} = changeset =
        attrs
        |> Map.put(:username, "Capital_Username")
        |> get_changeset()
      assert changeset.changes.username == "capital_username"
    end

    test "bad email format returns an invalid changeset", %{attrs: attrs} do
      assert %Changeset{} = changeset =
        attrs
        |> Map.put(:email, "invalid@email")
        |> get_changeset()
      refute changeset.valid?
    end

    test "username too short returns an invalid changeset", %{attrs: attrs} do
      # Too short
      assert %Changeset{} = changeset =
        attrs
        |> Map.put(:username, "a")
        |> get_changeset()
      refute changeset.valid?
    end

    test "username with bad format returns an invalid changeset", %{attrs: attrs} do
      assert %Changeset{} = changeset =
        attrs
        |> Map.put(:username, "_asdfa")
        |> get_changeset()
      refute changeset.valid?
    end

    test "passwords that don't match returns invalid changeset", %{attrs: attrs} do
      assert %Changeset{} = changeset =
        attrs
        |> Map.put(:password_confirmation, "different password")
        |> get_changeset()
      refute changeset.valid?
    end

    test "password that's too short returns invalid changeset", %{attrs: attrs} do
      assert %Changeset{} = changeset =
        attrs
        |> Map.put(:password, "a")
        |> Map.put(:password_confirmation, "a")
        |> get_changeset()
      refute changeset.valid?
    end

    test "already taken email returns invalid changeset on insert", %{attrs: attrs} do
      {:ok, _user} = AdoptAFamily.Accounts.create_user(attrs)
      assert {:error, %Changeset{} = changeset} =
        attrs
        |> Map.put(:username, "different_username")
        |> get_changeset()
        |> Repo.insert()
      refute changeset.valid?
    end

    test "already taken username returns invalid changeset on insert", %{attrs: attrs} do
      {:ok, _user} = AdoptAFamily.Accounts.create_user(attrs)
      assert {:error, %Changeset{} = changeset} =
        attrs
        # |> Map.put(:email, "different@test.com")
        |> get_changeset()
        |> Repo.insert()
      refute changeset.valid?
    end
  end
end
