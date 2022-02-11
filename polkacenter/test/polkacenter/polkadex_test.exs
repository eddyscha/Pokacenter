defmodule Polkacenter.PolkadexTest do
  use Polkacenter.DataCase

  alias Polkacenter.Polkadex

  describe "blocks" do
    alias Polkacenter.Polkadex.Block

    import Polkacenter.PolkadexFixtures

    @invalid_attrs %{author: nil, block_hash: nil}

    test "list_blocks/0 returns all blocks" do
      block = block_fixture()
      assert Polkadex.list_blocks() == [block]
    end

    test "get_block!/1 returns the block with given id" do
      block = block_fixture()
      assert Polkadex.get_block!(block.id) == block
    end

    test "create_block/1 with valid data creates a block" do
      valid_attrs = %{author: "some author", block_hash: "some block_hash"}

      assert {:ok, %Block{} = block} = Polkadex.create_block(valid_attrs)
      assert block.author == "some author"
      assert block.block_hash == "some block_hash"
    end

    test "create_block/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Polkadex.create_block(@invalid_attrs)
    end

    test "update_block/2 with valid data updates the block" do
      block = block_fixture()
      update_attrs = %{author: "some updated author", block_hash: "some updated block_hash"}

      assert {:ok, %Block{} = block} = Polkadex.update_block(block, update_attrs)
      assert block.author == "some updated author"
      assert block.block_hash == "some updated block_hash"
    end

    test "update_block/2 with invalid data returns error changeset" do
      block = block_fixture()
      assert {:error, %Ecto.Changeset{}} = Polkadex.update_block(block, @invalid_attrs)
      assert block == Polkadex.get_block!(block.id)
    end

    test "delete_block/1 deletes the block" do
      block = block_fixture()
      assert {:ok, %Block{}} = Polkadex.delete_block(block)
      assert_raise Ecto.NoResultsError, fn -> Polkadex.get_block!(block.id) end
    end

    test "change_block/1 returns a block changeset" do
      block = block_fixture()
      assert %Ecto.Changeset{} = Polkadex.change_block(block)
    end
  end
end
