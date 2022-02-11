defmodule Polkacenter.Repo.Migrations.CreateBlocks do
  use Ecto.Migration

  def change do
    create table(:blocks) do
      add :block_hash, :string
      add :author, :string

      timestamps()
    end
  end
end
