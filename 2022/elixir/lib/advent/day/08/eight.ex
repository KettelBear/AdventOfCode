defmodule Advent.Day.Eight do
  @moduledoc false

  alias Advent.Utility

  @max_idx 98

  @doc """
  Consider your map; how many trees are visible from outside the grid?
  """
  def part1 do
    "#{__DIR__}/input.prod"
    |> Utility.parse_input!(grid: true)
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
          height == 9 -> {:halt, {9, MapSet.put(s, {row, col})}}
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
          height == 9 -> {:halt, {9, MapSet.put(s, {row, col})}}
          height > curr_max -> {:cont, {height, MapSet.put(s, {row, col})}}
          true -> {:cont, {curr_max, s}}
        end
      end)
      |> elem(1)
    end)
  end

  @doc """
  Consider each tree on your map. What is the highest scenic score possible for
  any tree?
  """
  def part2 do
    "#{__DIR__}/input.prod"
    |> Utility.parse_input!(grid: true)
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

    # Up
    line_product(1, map, height, get_line(col, row-1..0, true))
    # Down
    |> line_product(map, height, get_line(col, row+1..@max_idx, true))
    # Left
    |> line_product(map, height, get_line(row, col-1..0, false))
    # Right
    |> line_product(map, height, get_line(row, col+1..@max_idx, false))
  end

  defp get_line(const, range, column?) do
    c_list = const |> List.duplicate(Enum.count(range))

    if column?, do: Enum.zip(range, c_list), else: Enum.zip(c_list, range)
  end

  defp line_product(product, map, height, line) do
    product * Enum.reduce_while(line, 0, fn point, count ->
      if Map.get(map, point) < height do
        {:cont, count + 1}
      else
        {:halt, count + 1}
      end
    end)
  end
end
