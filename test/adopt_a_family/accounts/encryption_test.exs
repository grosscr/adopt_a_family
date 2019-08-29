defmodule AdoptAFamily.Accounts.EncryptionTest do
  use AdoptAFamily.DataCase

  import Double

  alias AdoptAFamily.Accounts.Encryption
  alias AdoptAFamily.Accounts.User

  setup do
    inject =
      Bcrypt
      |> stub(:hash_pwd_salt, fn(_) -> "hashed password" end)
      |> stub(:check_pass, fn(_, _) -> true end)

    %{bcrypt_inject: inject}
  end

  describe "hash_password/1" do
    test "hashes a password" do
      assert Encryption.hash_password("password") != "password"
    end

    test "calls `hash_pwd_salt`", %{bcrypt_inject: inj} do
      Encryption.hash_password("password", inj)
      assert_receive({Bcrypt, :hash_pwd_salt, ["password"]})
    end
  end

  describe "validate_password/2" do
    test "throws an error if it isn't given a user" do
      assert_raise FunctionClauseError, fn ->
        Encryption.validate_password(%{}, "password")
      end
    end

    test "validates the password" do
      {:ok, user} = AdoptAFamily.Accounts.create_user(%{
        email: "valid@email.com",
        username: "username",
        name: "name",
        password: "password",
        password_confirmation: "password"
      })

      assert Encryption.validate_password(user, "password")
    end

    test "calls `check_pass", %{bcrypt_inject: inj} do
      Encryption.validate_password(%User{}, "password", inj)
      assert_receive({Bcrypt, :check_pass, [%User{}, "password"]})
    end
  end
end
