defmodule Thermal do
  @moduledoc """
  Solutions for Day 5 for Advent of Code in Elixir.
  """

  @doc """
  Part 1 finds all thermal hot zones (2 or more) but only for
  horizontal or vertical thermal lines from the reading.
  """
  def part1() do
    parse_input("input.prod")
    |> do_part_1()
    |> tally_hot_zones()
  end

  @doc """
  Part 2 finds all thermal hot zones (2 or more) for horizontal,
  vertical, and diagonal lines.
  """
  def part2() do
    parse_input("input.prod")
    |> do_part_2()
    |> tally_hot_zones()
  end

  defp parse_input(in_file) do
    File.read!(in_file)
    |> String.split("\n")
  end

  defp do_part_1(lines, hydro_map \\ %{})
  defp do_part_1([], hydro_map), do: hydro_map
  defp do_part_1([line | rest], hydro_map) do
    [x1, y1, x2, y2] = parse_line_ends(line)

    cond do
      x1 == x2 -> do_part_1(rest, handle_vert(hydro_map, x1, y1, y2))
      y1 == y2 -> do_part_1(rest, handle_horiz(hydro_map, y1, x1, x2))
      true -> do_part_1(rest, hydro_map)
    end
  end

  defp do_part_2(lines, hydro_map \\ %{})
  defp do_part_2([], hydro_map), do: hydro_map
  defp do_part_2([line | rest], hydro_map) do
    [x1, y1, x2, y2] = parse_line_ends(line)

    cond do
      x1 == x2 -> do_part_2(rest, handle_vert(hydro_map, x1, y1, y2))
      y1 == y2 -> do_part_2(rest, handle_horiz(hydro_map, y1, x1, x2))
      true -> do_part_2(rest, handle_diag(hydro_map, x1, y1, x2, y2))
    end
  end

  defp parse_line_ends(line) do
    line
    |> String.split([",", " -> "])
    |> Enum.map(&String.to_integer/1)
  end

  defp handle_vert(map, x, y1, y2) do
    Enum.reduce(y1..y2, map, fn y, acc ->
      Map.update(acc, to_string(x, y), 1, fn val -> val + 1 end)
    end)
  end

  defp handle_horiz(map, y, x1, x2) do
    Enum.reduce(x1..x2, map, fn x, acc ->
      Map.update(acc, to_string(x, y), 1, fn val -> val + 1 end)
    end)
  end

  defp handle_diag(map, x1, y1, x2, y2) do
    Enum.zip(x1..x2, y1..y2)
    |> Enum.reduce(map, fn {x, y}, acc ->
      Map.update(acc, to_string(x, y), 1, fn val -> val + 1 end)
    end)
  end

  defp to_string(x, y) do
    Integer.to_string(x) <> "," <> Integer.to_string(y)
  end

  defp tally_hot_zones(hydro_map) do
    hydro_map
    |> Map.values()
    |> Enum.count(fn val -> val > 1 end)
  end
end
