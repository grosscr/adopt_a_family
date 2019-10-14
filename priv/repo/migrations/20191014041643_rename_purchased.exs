defmodule AdoptAFamily.Repo.Migrations.RenamePurchased do
  use Ecto.Migration

  def change do
    rename table(:gifts), :purchased, to: :shipped
    rename table(:family_gifts), :purchased, to: :shipped
  end
end
