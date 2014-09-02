defmodule Game do

  @doc"""
    Gets the number of neghbors on a board for a given x and y coordinate

    ## Examples
        iex> Game.get_neighbors({{0, 1, 0},
        ...>   {0, 1, 0},
        ...>   {0, 1, 0}},
        ...>   1, 1)
        2

        iex> Game.get_neighbors({{0, 1, 0},
        ...>   {0, 1, 0},
        ...>   {0, 1, 0}},
        ...>   1, 0)
        3
  """
  def get_neighbors(board, x, y) do
    Enum.reduce(-1..1, 0, fn mod_x, acc ->
      Enum.reduce(-1..1, acc, fn mod_y, inner_acc ->
        case {x + mod_x, y + mod_y} do
          {^x, ^y} -> inner_acc
          {get_x, get_y} when get_x < 0 or get_y < 0 or
                              get_x >= tuple_size(board) or
                              get_y >= tuple_size(elem(board, get_x)) -> inner_acc
          {get_x, get_y} -> inner_acc + elem(elem(board, get_x), get_y)
        end
      end)
    end)
  end

  def should_live(board, x, y) do
    neighbors = get_neighbors(board, x, y)
    neighbors == 3 || (elem(elem(board, x), y) == 1 && neighbors ==2)
  end

  def next_step(board) do
    :erlang.list_to_tuple(Enum.map(0..tuple_size(board) - 1, fn cur_x ->
      :erlang.list_to_tuple(Enum.map(0..tuple_size(elem(board, cur_x)) - 1, fn cur_y ->
        if (should_live(board, cur_x, cur_y)) do 1
        else 0
        end
      end))
    end))
  end
end
