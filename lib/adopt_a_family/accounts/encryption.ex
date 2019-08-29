defmodule AdoptAFamily.Accounts.Encryption do
  alias AdoptAFamily.Accounts.User

  def hash_password(password, mod \\ Bcrypt), do: mod.hash_pwd_salt(password)

  def validate_password(%User{} = user, password, mod \\ Bcrypt), do: mod.check_pass(user, password)
end
