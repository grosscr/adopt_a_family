defmodule AdoptAFamily.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :email, :string
    field :encrypted_password, :string
    field :name, :string
    field :username, :string

    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:email, :username, :password, :password_confirmation, :name])
    |> validate_required([:email, :username, :password, :password_confirmation])
    |> validate_length(:password, min: 8)
    |> validate_confirmation(:password)
    |> validate_format(:username, ~r/^[a-z0-9]+[a-z0-9_]+[a-z0-9]$/i)
    |> validate_length(:username, min: 5)
    |> validate_format(:email, ~r/^([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+$/i)
    |> unique_constraint(:email)
    |> unique_constraint(:username)
    # |> check_password_not_dumb() # TODO
    |> downcase_username()
    |> encrypt_password()
  end

  defp encrypt_password(changeset) do
    password = get_change(changeset, :password)
    if password do
      encrypted_password = AdoptAFamily.Accounts.Encryption.hash_password(password)
      put_change(changeset, :encrypted_password, encrypted_password)
    else
      changeset
    end
  end

  defp downcase_username(changeset) do
    update_change(changeset, :username, &String.downcase/1)
  end
end
