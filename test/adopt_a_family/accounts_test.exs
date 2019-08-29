defmodule AdoptAFamily.AccountsTest do
  use AdoptAFamily.DataCase

  alias AdoptAFamily.Accounts

  describe "users" do
    alias AdoptAFamily.Accounts.User

    setup do
      valid_attrs = %{
        email: "email@test.com",
        password: "password", password_confirmation: "password",
        name: "some name",
        username: "username"
      }

      update_attrs = %{
        email: "updated_email@test.com",
        password: "updated_password", password_confirmation: "updated_password",
        name: "some updated name",
        username: "updated_username"
      }

      {:ok, user} = Accounts.create_user(%{
        email: "staged_email@test.com",
        password: "password", password_confirmation: "password",
        name: "staged name",
        username: "staged_username"
      })

      %{
        valid_attrs: valid_attrs,
        update_attrs: update_attrs,
        user: user
      }
    end

    test "get_user!/1 returns the user with given id", %{user: %{id: user_id} = staged_user} do
      user = Accounts.get_user!(user_id)

      assert user.password == nil
      assert user.encrypted_password == nil
      assert user.email == staged_user.email
      assert user.name == staged_user.name
      assert user.username == staged_user.username
    end

    test "create_user/1 with valid data creates a user", %{valid_attrs: attrs} do
      assert {:ok, %User{} = user} = Accounts.create_user(attrs)
      assert user.email == attrs.email
      assert user.name == attrs.name
      assert user.username == attrs.username
    end

    test "create_user/1 with missing data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(%{})
    end

    test "update_user/2 with valid data updates the user", %{user: user, update_attrs: attrs} do
      assert {:ok, %User{} = user} = Accounts.update_user(user, attrs)
      assert user.email == attrs.email
      assert user.name == attrs.name
      assert user.username == attrs.username
    end

    test "update_user/2 with invalid data returns error changeset", %{user: user} do
      assert {:error, changeset} = Accounts.update_user(user, %{email: 'invalid@email'})
    end

    test "delete_user/1 deletes the user", %{valid_attrs: attrs} do
      {:ok, user} = Accounts.create_user(attrs)
      assert {:ok, %User{}} = Accounts.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      assert %Ecto.Changeset{} = Accounts.change_user(%User{})
    end
  end
end
