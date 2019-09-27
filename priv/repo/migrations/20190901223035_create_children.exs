defmodule AdoptAFamily.Repo.Migrations.CreateChildren do
  use Ecto.Migration

  def change do
    create table(:children) do
      add :name, :string
      add :gender, :string
      add :age, :integer
      add :interests, :text
      add :family_id, references(:families)

      timestamps()
    end
  end
end
