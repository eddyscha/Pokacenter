defmodule PolkacenterWeb.BlockLiveTest do
  use PolkacenterWeb.ConnCase

  import Phoenix.LiveViewTest
  import Polkacenter.PolkadexFixtures

  @create_attrs %{author: "some author", block_hash: "some block_hash"}
  @update_attrs %{author: "some updated author", block_hash: "some updated block_hash"}
  @invalid_attrs %{author: nil, block_hash: nil}

  defp create_block(_) do
    block = block_fixture()
    %{block: block}
  end

  describe "Index" do
    setup [:create_block]

    test "lists all blocks", %{conn: conn, block: block} do
      {:ok, _index_live, html} = live(conn, Routes.block_index_path(conn, :index))

      assert html =~ "Listing Blocks"
      assert html =~ block.author
    end

    test "saves new block", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.block_index_path(conn, :index))

      assert index_live |> element("a", "New Block") |> render_click() =~
               "New Block"

      assert_patch(index_live, Routes.block_index_path(conn, :new))

      assert index_live
             |> form("#block-form", block: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#block-form", block: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.block_index_path(conn, :index))

      assert html =~ "Block created successfully"
      assert html =~ "some author"
    end

    test "updates block in listing", %{conn: conn, block: block} do
      {:ok, index_live, _html} = live(conn, Routes.block_index_path(conn, :index))

      assert index_live |> element("#block-#{block.id} a", "Edit") |> render_click() =~
               "Edit Block"

      assert_patch(index_live, Routes.block_index_path(conn, :edit, block))

      assert index_live
             |> form("#block-form", block: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#block-form", block: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.block_index_path(conn, :index))

      assert html =~ "Block updated successfully"
      assert html =~ "some updated author"
    end

    test "deletes block in listing", %{conn: conn, block: block} do
      {:ok, index_live, _html} = live(conn, Routes.block_index_path(conn, :index))

      assert index_live |> element("#block-#{block.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#block-#{block.id}")
    end
  end

  describe "Show" do
    setup [:create_block]

    test "displays block", %{conn: conn, block: block} do
      {:ok, _show_live, html} = live(conn, Routes.block_show_path(conn, :show, block))

      assert html =~ "Show Block"
      assert html =~ block.author
    end

    test "updates block within modal", %{conn: conn, block: block} do
      {:ok, show_live, _html} = live(conn, Routes.block_show_path(conn, :show, block))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Block"

      assert_patch(show_live, Routes.block_show_path(conn, :edit, block))

      assert show_live
             |> form("#block-form", block: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#block-form", block: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.block_show_path(conn, :show, block))

      assert html =~ "Block updated successfully"
      assert html =~ "some updated author"
    end
  end
end
