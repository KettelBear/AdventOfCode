defmodule Bathroom do
  @moduledoc """
  You arrive at Easter Bunny Headquarters under cover of darkness. However, you
  left in such a rush that you forgot to use the bathroom! Fancy office
  buildings like this one usually have keypad locks on their bathrooms, so you
  search the front desk for the code.

  "In order to improve security," the document you find says, "bathroom codes
  will no longer be written down. Instead, please memorize and follow the
  procedure below to access the bathrooms."

  The document goes on to explain that each button to be pressed can be found
  by starting on the previous button and moving to adjacent buttons on the
  keypad: U moves up, D moves down, L moves left, and R moves right. Each line
  of instructions corresponds to one button, starting at the previous button
  (or, for the first line, the "5" button); press whatever button you're on at
  the end of each line. If a move doesn't lead to a button, ignore it.
  """
  @right %{"2"=> "3", "3"=> "4", "5"=> "6", "6"=> "7", "7"=> "8", "8"=> "9", "A"=> "B", "B"=> "C"}
  @left %{"3"=> "2", "4"=> "3", "6"=> "5", "7"=> "6", "8"=> "7", "9"=> "8", "B"=> "A", "C"=> "B"}
  @up %{"3"=> "1", "6"=> "2", "7"=> "3", "8"=> "4", "A"=> "6", "B"=> "7", "C"=> "8", "D"=> "B"}
  @down %{"1"=> "3", "2"=> "6", "3"=> "7", "4"=> "8", "6"=> "A", "7"=> "B", "8"=> "C", "B"=> "D"}

  @doc """
  Keypad looks like:

  1 2 3
  4 5 6
  7 8 9

  What is the bathroom code?
  """
  def part1(), do: parse_input("input.prod") |> follow_tenkey()

  defp follow_tenkey(instr), do: follow_tenkey([5], instr)
  defp follow_tenkey(code, []), do: Enum.reverse(code) |> tl() |> Enum.join()
  defp follow_tenkey(code, [set | instructions]) do
    code
    |> follow_set(set, &next_digit/2)
    |> follow_tenkey(instructions)
  end

  defp next_digit("R", digit), do: if digit in [3, 6, 9], do: digit, else: digit + 1
  defp next_digit("L", digit), do: if digit in [1, 4, 7], do: digit, else: digit - 1
  defp next_digit("D", digit), do: if digit in [7, 8, 9], do: digit, else: digit + 3
  defp next_digit("U", digit), do: if digit in [1, 2, 3], do: digit, else: digit - 3

  @doc """
  Keypad looks like:

      1
    2 3 4
  5 6 7 8 9
    A B C
      D

  What is the bathroom code?
  """
  def part2(), do: parse_input("input.prod") |> follow_keypad()

  defp follow_keypad(instr), do: follow_keypad(["5"], instr)
  defp follow_keypad(code, []), do: Enum.reverse(code) |> tl() |> Enum.join()
  defp follow_keypad(code, [set | instructions]) do
    code
    |> follow_set(set, &next_key/2)
    |> follow_keypad(instructions)
  end

  defp next_key("R", digit), do: Map.get(@right, digit, digit)
  defp next_key("L", digit), do: Map.get(@left, digit, digit)
  defp next_key("D", digit), do: Map.get(@down, digit, digit)
  defp next_key("U", digit), do: Map.get(@up, digit, digit)

  defp follow_set([last_digit | digits], set, func) do
    [Enum.reduce(set, last_digit, func), last_digit | digits]
  end

  defp parse_input(file) do
    file
    |> File.read!()
    |> String.split(["\n", "\r\n"], trim: true)
    |> Enum.map(&String.graphemes/1)
  end
end

