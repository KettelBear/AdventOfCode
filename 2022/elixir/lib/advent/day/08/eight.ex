defmodule Advent.Day.Eight do
  @moduledoc false

  alias Advent.Utility

  @max_idx 98

  @doc """

  """
  def part1 do
    "#{__DIR__}/input.prod"
    |> Utility.parse_input!(graphemes: true, integers: true)
    |> generate_map()
    |> collect_visible()
    |> Enum.count()
  end

  defp collect_visible(tree_map), do: collect_visible(MapSet.new(), tree_map)
  defp collect_visible(set, map) do
    set
    |> count_horiz(map, 0..@max_idx, 0..@max_idx)
    |> count_horiz(map, 0..@max_idx, @max_idx..0)
    |> count_vert(map, 0..@max_idx, 0..@max_idx)
    |> count_vert(map, 0..@max_idx, @max_idx..0)
  end

  defp count_horiz(set, map, rows, columns) do
    Enum.reduce(rows, set, fn row, points ->
      Enum.reduce_while(columns, {-1, points}, fn col, {curr_max, s} ->
        height = Map.get(map, {row, col})
        cond do
          height == 9 and height > curr_max -> {:halt, {9, MapSet.put(s, {row, col})}}
          height > curr_max -> {:cont, {height, MapSet.put(s, {row, col})}}
          true -> {:cont, {curr_max, s}}
        end
      end)
      |> elem(1)
    end)
  end

  defp count_vert(set, map, columns, rows) do
    Enum.reduce(columns, set, fn col, points ->
      Enum.reduce_while(rows, {-1, points}, fn row, {curr_max, s} ->
        height = Map.get(map, {row, col})
        cond do
          height == 9 and height > curr_max -> {:halt, {9, MapSet.put(s, {row, col})}}
          height > curr_max -> {:cont, {height, MapSet.put(s, {row, col})}}
          true -> {:cont, {curr_max, s}}
        end
      end)
      |> elem(1)
    end)
  end

  @doc """

  """
  def part2 do
    "#{__DIR__}/input.prod"
    |> Utility.parse_input!(graphemes: true, integers: true)
    |> generate_map()
    |> highest_scenic_score()
  end

  defp highest_scenic_score(map) do
    Enum.reduce(map, 0, fn {point, _}, curr_high ->
      scenic_score = calculate_scenic(map, point)
      if scenic_score > curr_high, do: scenic_score, else: curr_high
    end)
  end

  defp calculate_scenic(map, {row, col} = point) do
    height = Map.get(map, point)

    up = Enum.reduce_while(row-1..0, 0, fn r, tree_count ->
      case Map.get(map, {r, col}) do
        nil -> {:halt, tree_count}
        h when h >= height -> {:halt, tree_count + 1}
        _ -> {:cont, tree_count + 1}
      end
    end)

    down = Enum.reduce_while(row+1..@max_idx, 0, fn r, tree_count ->
      case Map.get(map, {r, col}) do
        nil -> {:halt, tree_count}
        h when h >= height -> {:halt, tree_count + 1}
        _ -> {:cont, tree_count + 1}
      end
    end)

    left = Enum.reduce_while(col-1..0, 0, fn c, tree_count ->
      case Map.get(map, {row, c}) do
        nil -> {:halt, tree_count}
        h when h >= height -> {:halt, tree_count + 1}
        _ -> {:cont, tree_count + 1}
      end
    end)

    right = Enum.reduce_while(col+1..@max_idx, 0, fn c, tree_count ->
      case Map.get(map, {row, c}) do
        nil -> {:halt, tree_count}
        h when h >= height -> {:halt, tree_count + 1}
        _ -> {:cont, tree_count + 1}
      end
    end)

    up * down * left * right
  end

  ##############################
  #                            #
  #     Used By Both Parts     #
  #                            #
  ##############################

  defp generate_map(tree_heights) do
    for {line, row} <- Enum.with_index(tree_heights),
        {height, col} <- Enum.with_index(line), into: %{} do
      {{row, col}, height}
    end
  end
end
