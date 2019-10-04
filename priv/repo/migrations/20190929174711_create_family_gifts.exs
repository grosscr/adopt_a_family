defmodule AdoptAFamily.Repo.Migrations.CreateFamilyGifts do
  use Ecto.Migration

  def change do
    create table(:family_gifts) do
      add :item, :string
      add :purchaser_id, :integer
      add :price, :decimal
      add :via_paypal, :boolean, default: false, null: false
      add :receipt_id, :integer
      add :family_id, :integer
      add :purchased, :boolean, default: false, null: false

      timestamps()
    end

  end
end
