defmodule AdoptAFamily.Repo.Migrations.CreateGifts do
  use Ecto.Migration

  def change do
    create table(:gifts) do
      add :item, :string
      add :size, :string
      add :purchaser_id, :integer
      add :price, :decimal
      add :via_paypal, :boolean, default: false, null: false
      add :receipt_id, :integer
      add :child_id, :integer
      add :purchased, :boolean, default: false, null: false

      timestamps()
    end

  end
end
