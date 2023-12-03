defmodule Advent.Day.Two do
  @moduledoc false

  @red 12
  @green 13
  @blue 14

  import Advent.Utility

  @doc """
  Determine which games would have been possible if the bag had been loaded
  with only 12 red cubes, 13 green cubes, and 14 blue cubes. What is the sum of
  the IDs of those games?
  """
  def part1 do
    "#{__DIR__}/input.prod"
    |> parse_input!(split: ": ")
    |> Stream.filter(&valid_game?/1)
    |> Stream.map(&game_id/1)
    |> Enum.sum()
  end

  defp valid_game?([_, handfuls]) do
    rounds = split(handfuls, "; ")
    Enum.all?(rounds, &play?/1)
  end

  defp play?(handful) do
    handful
    |> split(", ")
    |> Enum.all?(fn num_of_color ->
      case split(num_of_color, " ") do
        [num, "red"] -> stoi(num) <= @red
        [num, "green"] -> stoi(num) <= @green
        [num, "blue"] -> stoi(num) <= @blue
      end
    end)
  end

  defp game_id([game, _]) do
    game
    |> split(" ")
    |> then(fn [_, n] -> n end)
    |> stoi()
  end

  @doc """
  For each game, find the minimum set of cubes that must have been present.
  What is the sum of the power of these sets?
  """
  def part2 do
    "#{__DIR__}/input.prod"
    |> parse_input!(split: ": ")
    |> Stream.map(&power/1)
    |> Enum.sum()
  end

  defp power([_, handfuls]) do
    handfuls
    |> split("; ")
    |> Enum.reduce({-1, -1, -1}, &max_by_handful/2)
    |> Tuple.product()
  end

  defp max_by_handful(handful, acc) do
    handful
    |> split(", ")
    |> Enum.reduce(acc, fn num_of_color, {r, g, b} ->
      case split(num_of_color, " ") do
        [num, "red"] -> {num |> stoi() |> max(r), g, b}
        [num, "green"] -> {r, num |> stoi() |> max(g), b}
        [num, "blue"] -> {r, g, num |> stoi() |> max(b)}
      end
    end)
  end
end
