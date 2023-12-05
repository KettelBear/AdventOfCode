defmodule Advent.Day.Six do
  @moduledoc false

  import Advent.Utility

  @doc """

  """
  def part1 do
    "#{__DIR__}/input.test"
    |> parse_input!(split: [": ", " "])
    |> format_numbers()
    |> Enum.zip()
    |> winning_product()
  end

  defp format_numbers(lists) do
    lists
    |> Stream.map(&tl/1)
    |> Stream.map(fn list -> Stream.map(list, &stoi/1) end)
  end

  defp winning_product([]), do: 1
  defp winning_product([{time, dist} | rest]) do
    half = div(time, 2)

    # time in race 7 seconds, time held is 3. time - time_held * time held
    wins = Enum.reduce_while(half..0, 0, fn time_held, wins ->
      if (time - time_held) * time_held > dist do
        {:cont, wins + 1}
      else
        {:halt, wins}
      end
    end)

    if rem(time, 2) == 1 do
      wins * 2 * winning_product(rest)
    else
      (wins * 2 - 1) * winning_product(rest)
    end

  end

  @doc """

  """
  def part2 do
    "#{__DIR__}/input.test"
    |> parse_input!(split: [": ", " "])
    |> format_number()
    |> total_wins()
  end

  defp total_wins([time, distance]) do
    highest_loss = binary_wins(0, time, time, distance)

    ((div(time, 2) - highest_loss) * 2) - 1
  end

  defp binary_wins(bottom, top, time, winning_dist) do
    half = bottom + top |> div(2)
    win_at_hold? = (time - half) * half > winning_dist
    win_less_one_milli? = (time - (half - 1)) * (half - 1) > winning_dist
    cond do
      win_at_hold? and win_less_one_milli? ->
        # Something about moving the window. I need to consider the new top of the window.
        binary_wins(bottom, half, time, winning_dist)

      win_at_hold? ->
        half - 1

      true ->
        binary_wins(half + 1, top, time, winning_dist)
    end
  end

  defp format_number(lists) do
    lists
    |> Stream.map(&tl/1)
    |> Stream.map(&Enum.join/1)
    |> Enum.map(&stoi/1)
  end
end
