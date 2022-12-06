defmodule Advent.Day.Three do
  @moduledoc false

  alias Advent.Utility

  @doc """
  Find the item type that appears in both compartments of each rucksack. What is
  the sum of the priorities of those item types?
  """
  def part1 do
    "#{__DIR__}/input.prod"
    |> Utility.parse_input!(charlist: true)
    |> Enum.map(&(find_error(&1) |> priority()))
    |> Enum.sum()
  end

  defp find_error(chars) do
    middle_index = chars |> length() |> div(2)

    {first, second} = Enum.split(chars, middle_index)

    Enum.find(first, &Enum.member?(second, &1))
  end

  @doc """
  Find the item type that corresponds to the badges of each three-Elf group.
  What is the sum of the priorities of those item types?
  """
  def part2 do
    "#{__DIR__}/input.prod"
    |> Utility.parse_input!(charlist: true)
    |> Enum.chunk_every(3)
    |> Enum.map(&(find_badge(&1) |> priority()))
    |> Enum.sum()
  end

  defp find_badge([first, second, third]) do
    Enum.find(first, &(Enum.member?(second, &1) and Enum.member?(third, &1)))
  end

  ##############################
  #                            #
  #     Used By Both Parts     #
  #                            #
  ##############################

  defp priority(char) when char >= ?a and char <= ?z, do: char - ?a + 1
  defp priority(char) when char >= ?A and char <= ?Z, do: char - ?A + 27
end
