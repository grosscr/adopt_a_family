defmodule AdoptAFamily.Repo.Migrations.CreateFamilies do
  use Ecto.Migration

  def change do
    create table(:families) do
      add :head_of_house, :string
      add :clinician, :string

      timestamps()
    end

  end
end
