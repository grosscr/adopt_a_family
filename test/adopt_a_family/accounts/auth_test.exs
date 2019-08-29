defmodule AdoptAFamily.Accounts.AuthTest do
  use AdoptAFamily.DataCase

  alias AdoptAFamily.Accounts.Auth

  setup do
    {:ok, user} = AdoptAFamily.Accounts.create_user(%{
      email: "staged_email@test.com",
      password: "password", password_confirmation: "password",
      name: "staged name",
      username: "staged_username"
    })

    %{
      user: user,
      params: %{
        "username" => user.username,
        "password" => "password"
      }
    }
  end

  describe "login/1" do
    test "returns ok if password matches", %{params: params} do
      assert {:ok, _user} = Auth.login(params)
    end

    test "returns error if password doesn't match", %{params: params} do
      assert :error = Auth.login(Map.put(params, "password", "bad password"))
    end

    test "returns error if the user can't be found" do
      assert :error = Auth.login(%{"username" => "invalid_user"})
    end
  end

  describe "signed_in?/1" do
    test "returns the assigned current_user from the connection", %{user: user} do
      conn = %Plug.Conn{assigns: %{current_user: user}}
      assert Auth.signed_in?(conn) == user
    end
  end
end
