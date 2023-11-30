defmodule Advent.Day.One do
  @moduledoc false

  alias Advent.Utility

  @doc """

  """
  def part1 do
    "#{__DIR__}/input.prod"
    |> Utility.parse_input!()
  end

  @doc """

  """
  def part2 do
    "#{__DIR__}/input.prod"
    |> Utility.parse_input!()

    -1
  end

  ##############################
  #                            #
  #     Used By Both Parts     #
  #                            #
  ##############################
end
