defmodule Lanternfish do
  @moduledoc """
    Solutions for Day 6 for Advent of Code in Elixir.
  """

  @doc """
  Part 1 simulates population growth over 80 days.
  """
  def part1() do
    parse_input("input.prod")
    |> simulate(80)
    |> count_pop()
  end

  @doc """
  Part 2 simulates population growth over 256 days.
  """
  def part2() do
    parse_input("input.prod")
    |> simulate(256)
    |> count_pop()
  end

  defp simulate(population, 0), do: population
  defp simulate(population, days) do
    population
    |> Enum.reduce(%{}, &increment_day/2)
    |> simulate(days - 1)
  end

  defp increment_day({0, curr_pop}, population_map) do
    # When a Laternfish has 0 days left, it spawns a new
    # Laternfish (which has an initial reproductive cycle
    # of 8 days), and starts its reproductive cycle back
    # at 6 days.
    population_map
    |> Map.put(8, curr_pop)
    |> Map.update(6, curr_pop, &(&1 + curr_pop))
  end
  defp increment_day({timer, curr_pop}, population_map) do
    Map.update(population_map, timer - 1, curr_pop, &(&1 + curr_pop))
  end

  defp count_pop(pop_map) do
    pop_map
    |> Map.values()
    |> Enum.sum()
  end

  defp parse_input(in_file) do
    File.read!(in_file)
    |> String.trim()
    |> String.split(",")
    |> Enum.map(&String.to_integer/1)
    |> Enum.frequencies()
  end
end
