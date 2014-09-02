import Game

ExUnit.start()

defmodule GameTest do
  use ExUnit.Case
  doctest Game

  test "find the number of neighbors" do
    board = {{0, 1, 0},
             {1, 1, 0},
             {0, 0, 0}}

    assert get_neighbors(board, 1, 1) == 2
  end

  test "should live" do
    board = {{0, 1, 0},
             {1, 1, 0},
             {0, 0, 1}}

    assert should_live(board, 1, 1)
    assert should_live(board, 0, 0)
    assert !should_live(board, 0, 2)
    assert !should_live(board, 2, 2)
  end

  test "next step" do
    board = {{0, 1, 0},
             {0, 1, 0},
             {0, 1, 0}}

    new_board = {{0, 0, 0},
                 {1, 1, 1},
                 {0, 0, 0}}

    assert next_step(board) == new_board
    assert next_step(next_step(board)) == board
  end
end
