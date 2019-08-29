defmodule AdoptAFamily.Accounts.Auth do
  alias AdoptAFamily.Accounts.{Encryption, User}

  def login(params) do
    user = AdoptAFamily.Repo.get_by(User, username: String.downcase(params["username"]))
    case authenticate(user, params["password"]) do
      true -> {:ok, user}
      _    -> :error
    end
  end

  defp authenticate(nil, _password), do: nil
  defp authenticate(user, password) do
    case  Encryption.validate_password(user, password) do
      {:ok, authenticated_user} ->
        authenticated_user.username == user.username
      {:error, "invalid password"} -> false
      _ -> :error
    end
  end

  def signed_in?(conn) do
    conn.assigns[:current_user]
  end
end
