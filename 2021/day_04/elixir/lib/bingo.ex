defmodule Bingo do
  @moduledoc """
    Solutions for Day 4 for Advent of Code in Elixir.
  """

  @doc """
  Part 1 finds the first winning bingo board and reports
  its score; sum(uncalled_nums) * last number called
  """
  def part1() do
    [nums_csv | janky_boards] = get_input("input.prod")

    nums_drawn = get_calling_nums(nums_csv)
    clean_boards = get_clean_boards(janky_boards)

    {boards, remaining_nums} = draw_first_four_nums(clean_boards, nums_drawn)

    # Then start looking for a winner after each number is called.
    {winning_board, last_called} = find_first_winner(boards, remaining_nums)

    sum_winning_board(winning_board) * last_called
  end

  @doc """
  Part 2 finds the last winning bingo board, and reports
  its score; sum(uncalled_nums) * last number called. This
  is in the event we want to ensure the giant squid wins.
  """
  def part2() do
    [nums_csv | janky_boards] = get_input("input.prod")

    {boards, remaining_nums} =
      janky_boards
      |> get_clean_boards()
      |> draw_first_four_nums(get_calling_nums(nums_csv))

    {winning_board, last_called} = find_last_winner(boards, remaining_nums)

    sum_winning_board(winning_board) * last_called
  end

  defp sum_winning_board(board) do
    board
    |> List.flatten()
    |> Enum.filter(fn {_value, called} -> not called end)
    |> Enum.reduce(0, fn {value, _called}, acc -> acc + value end)
  end

  defp draw_first_four_nums(clean_boards, numbers) do
    # Call the first four numbers, because no winner can be found.
    [first, second, third, fourth | remaining_nums] = numbers
    boards = call_number(clean_boards, first) |> call_number(second) |> call_number(third) |> call_number(fourth)

    {boards, remaining_nums}
  end

  defp find_first_winner(_boards, []), do: :error
  defp find_first_winner(boards, [num_to_call | remaining]) do
    boards = boards |> call_number(num_to_call)

    winner = boards |> Enum.filter(&is_winner?/1)

    case winner do
      [] ->
        find_first_winner(boards, remaining)
      [winner] ->
        {winner, num_to_call}
    end
  end

  defp find_last_winner(_boards, []), do: :error
  defp find_last_winner([last_board], numbers_to_call) do
    find_first_winner([last_board], numbers_to_call)
  end
  defp find_last_winner(boards, [num_to_call | rest]) do
    boards
    |> call_number(num_to_call)
    |> Enum.reject(&is_winner?/1)
    |> find_last_winner(rest)
  end

  defp get_input(in_file) do
    File.read!(in_file)
    |> String.split("\n\n", trim: true)
  end

  defp get_calling_nums(nums_csv) do
    nums_csv
    |> String.split(",", trim: true)
    |> Enum.map(&String.to_integer/1)
  end

  defp get_clean_boards(janky_boards) do
    janky_boards
    |> Enum.map(&String.split(&1, "\n", trim: true))
    |> Enum.map(fn board ->
      Enum.map(board, fn row ->
        row
        |> String.split(" ", trim: true)
        |> Enum.map(fn value -> {String.to_integer(value), false} end)
      end)
    end)
  end

  defp call_number(boards, num_called) do
    for board <- boards do
      for row <- board do
        for {value, called} <- row do
          if value == num_called do
            {value, true}
          else
            {value, called}
          end
        end
      end
    end
  end

  defp is_winner?(board) do
    columns = board |> List.zip() |> Enum.map(&Tuple.to_list/1)
    row_win = Enum.any?(board, &is_winning_row?/1)
    col_win = Enum.any?(columns, &is_winning_row?/1)
    row_win or col_win
  end

  def is_winning_row?(row) do
    Enum.all?(row, fn {_value, called} -> called end)
  end
end
