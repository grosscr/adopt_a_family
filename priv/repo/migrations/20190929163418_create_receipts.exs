defmodule AdoptAFamily.Repo.Migrations.CreateReceipts do
  use Ecto.Migration

  def change do
    create table(:receipts) do
      add :receipt, :bytea

      timestamps()
    end

  end
end
