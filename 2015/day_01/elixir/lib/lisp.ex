defmodule Lisp do
  @moduledoc """
  Santa is trying to deliver presents in a large apartment building, but he
  can't find the right floor - the directions he got are a little confusing.
  He starts on the ground floor (floor 0) and then follows the instructions
  one character at a time.
  An opening parenthesis, (, means he should go up one floor, and a closing
  parenthesis, ), means he should go down one floor.
  The apartment building is very tall, and the basement is very deep; he
  will never find the top or bottom floors.
  """

  @doc """
  To what floor do the instructions take Santa?
  """
  def part1(), do: parse_input("input.prod") |> Enum.frequencies() |> then(fn %{"(" => u, ")" => d} -> u - d end)

  @doc """
  What is the position of the character that causes Santa to first enter the
  basement?
  """
  def part2(), do: parse_input("input.prod") |> Enum.reduce_while({0, 0}, &enter_basement/2)

  defp enter_basement(paren, {position, floor}) do
    cond do
      floor == -1 -> {:halt, position}
      paren == "(" -> {:cont, {position + 1, floor + 1}}
      true -> {:cont, {position + 1, floor - 1}}
    end
  end

  defp parse_input(in_file), do: File.read!(in_file) |> String.graphemes()
end
