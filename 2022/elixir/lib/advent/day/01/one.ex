defmodule Advent.Day.One do
  @moduledoc false

  alias Advent.Utility

  @doc """
  Find the Elf carrying the most Calories. How many total Calories is that Elf
  carrying?
  """
  def part1 do
    "#{__DIR__}/input.prod"
    |> Utility.parse_input!(double: true, integers: true)
    |> Enum.reduce(0, &find_snack_man/2)
  end

  defp find_snack_man(elf, most_calories) do
    calories = Enum.sum(elf)

    if calories > most_calories, do: calories, else: most_calories
  end

  @doc """
  Find the top three Elves carrying the most Calories. How many Calories are
  those Elves carrying in total?
  """
  def part2 do
    "#{__DIR__}/input.prod"
    |> Utility.parse_input!(double: true, integers: true)
    |> Enum.reduce([0, 0, 0], &calorie_count/2)
    |> Enum.sum()
  end

  defp calorie_count(elf, [biggest, bigger, big] = acc) do
      total_calories = Enum.sum(elf)

      cond do
        total_calories > biggest ->
          [total_calories, biggest, bigger]

        total_calories > bigger ->
          [biggest, total_calories, bigger]

        total_calories > big ->
          [biggest, bigger, total_calories]

        true ->
          acc
      end
  end
end
