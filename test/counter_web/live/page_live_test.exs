defmodule CounterWeb.PageLiveTest do
  use CounterWeb.ConnCase
  import Phoenix.LiveViewTest

  test "disconnected and connected render", %{conn: conn} do
    {:ok, page_live, disconnected_html} = live(conn, "/")
    assert disconnected_html =~ "0"
    assert render(page_live) =~ "0"
  end

  test "increment event and decrement", %{conn: conn} do
    {:ok, page_live, _html} = live(conn, "/")
    assert render_click(page_live, :inc, %{}) =~ "1"
    assert render_click(page_live, :inc, %{}) =~ "2"
    assert render_click(page_live, :inc, %{}) =~ "3"
    assert render_click(page_live, :dec, %{}) =~ "2"
    assert render_click(page_live, :dec, %{}) =~ "1"
    assert render_click(page_live, :dec, %{}) =~ "0"
    # Extra Click should be zero as the minimum
    assert render_click(page_live, :dec, %{}) =~ "0"
  end

  test "upper limit test on increment", %{conn: conn} do
    {:ok, page_live, _html} = live(conn, "/")
    # simulate 130 clicks
    Enum.each(0..130, fn(_x) -> render_click(page_live, :inc, %{}) end )
    assert render_click(page_live, :inc, %{}) =~ "99"
    assert render_click(page_live, :inc, %{}) =~ "99"
    assert render_click(page_live, :dec, %{}) =~ "98"
    assert render_click(page_live, :dec, %{}) =~ "97"
  end

  test "clear event", %{conn: conn} do
    {:ok, page_live, _html} = live(conn, "/")
    assert render_click(page_live, :inc, %{}) =~ "1"
    assert render_click(page_live, :clear, %{}) =~ "0"
  end

  # test "check icon change on button clicks", %{conn: conn}  do
  #   {:ok, page_live, _html} = live(conn, "/")
  #   assert render_click(page_live, :clear, %{}) =~ "0"
  #   # test actcon icon state in different clicks  🔺/🔻/🧑🏾‍💻
  # end

end
