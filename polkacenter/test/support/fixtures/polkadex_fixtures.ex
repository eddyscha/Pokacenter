defmodule Polkacenter.PolkadexFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Polkacenter.Polkadex` context.
  """

  @doc """
  Generate a block.
  """
  def block_fixture(attrs \\ %{}) do
    {:ok, block} =
      attrs
      |> Enum.into(%{
        author: "some author",
        block_hash: "some block_hash"
      })
      |> Polkacenter.Polkadex.create_block()

    block
  end
end
