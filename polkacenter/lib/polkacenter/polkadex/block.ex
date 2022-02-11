defmodule Polkacenter.Polkadex.Block do
  use Ecto.Schema
  import Ecto.Changeset

  schema "blocks" do
    field :author, :string
    field :block_hash, :string

    timestamps()
  end

  @doc false
  def changeset(block, attrs) do
    block
    |> cast(attrs, [:block_hash, :author])
    |> validate_required([:block_hash, :author])
  end
end
