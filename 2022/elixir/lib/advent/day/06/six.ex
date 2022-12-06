defmodule Advent.Day.Six do
  @moduledoc false

  alias Advent.Utility

  @doc """
  How many characters need to be processed before the first start-of-packet
  marker is detected?
  """
  def part1 do
    "#{__DIR__}/input.prod"
    |> Utility.parse_input!(multi: false, graphemes: true)
    |> packet_marker(4)
  end

  @doc """
  How many characters need to be processed before the first start-of-message
  marker is detected?
  """
  def part2 do
    "#{__DIR__}/input.prod"
    |> Utility.parse_input!(multi: false, graphemes: true)
    |> packet_marker(14)
  end

  ##############################
  #                            #
  #     Used By Both Parts     #
  #                            #
  ##############################

  defp packet_marker(chars, marker) do
    Enum.reduce_while(chars, {0, []}, fn char, {idx, acc} ->
      cond do
        MapSet.new(acc) |> Enum.count() == marker -> {:halt, idx}
        Enum.count(acc) < marker -> {:cont, {idx + 1, [char | acc]}}
        true -> {:cont, {idx + 1, [char | List.delete_at(acc, -1)]}}
      end
    end)
  end
end
