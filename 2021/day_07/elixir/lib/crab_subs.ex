defmodule CrabSubs do
  @moduledoc """
  Solutions for Day 7 for Advent of Code in Elixir.
  """

  @doc """
  Part 1 considers that only 1 fuel unit is burned per position
  changed, and we want to find the least amount of fuel burned
  for all crabs.
  """
  def part1() do
    parse_input("input.prod")
    |> calculate_fuel(&sum_fuel/2)
    |> Enum.min()
  end

  @doc """
  Part 2 considers that n+1 fuel is burned for each position
  change, and we still want to find the least amount of fuel
  burned for all crabs in their submarines.
  """
  def part2() do
    parse_input("input.prod")
    |> calculate_fuel(&sum_of_nums_fuel/2)
    |> Enum.min()
  end

  defp calculate_fuel(positions, fuel_cost_fun) do
    Enum.min(positions)..Enum.max(positions)
    |> Enum.map(&fuel_cost_fun.(&1, positions))
  end

  defp sum_fuel(dist, positions) do
    positions
    |> Enum.reduce(0, fn val, acc -> acc + abs(val - dist) end)
  end

  defp sum_of_nums_fuel(dist, positions) do
    positions
    |> Enum.reduce(0, fn val, acc -> acc + ((abs(val - dist) * (abs(val - dist) + 1)) / 2) end)
  end

  defp parse_input(in_file) do
    File.read!(in_file)
    |> String.trim()
    |> String.split(",")
    |> Enum.map(&String.to_integer/1)
  end
end
