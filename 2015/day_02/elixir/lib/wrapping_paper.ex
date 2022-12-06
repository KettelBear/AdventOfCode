defmodule WrappingPaper do
  @moduledoc """
  The elves are running low on wrapping paper, and so they need to submit an
  order for more. They have a list of the dimensions (length l, width w, and
  height h) of each present, and only want to order exactly as much as they
  need.
  Fortunately, every present is a box (a perfect right rectangular prism),
  which makes calculating the required wrapping paper for each gift a little
  easier: find the surface area of the box, which is 2*l*w + 2*w*h + 2*h*l.
  The elves also need a little extra paper for each present: the area of the
  smallest side.
  """

  @doc """
  All numbers in the elves' list are in feet. How many total square feet of
  wrapping paper should they order?
  """
  def part1(), do: parse_input("input.prod") |> Enum.reduce(0, fn [s, m, l], sqft -> sqft + 3*s*m + 2*s*l + 2*m*l end)

  @doc """
  How many total feet of ribbon should they order?
  """
  def part2(), do: parse_input("input.prod") |> Enum.reduce(0, fn [s, m, l], feet -> feet + 2*s + 2*m + s*m*l end)

  defp parse_input(in_file) do
    File.read!(in_file)
    |> String.split(["\n", "\r\n"], trim: true)
    |> Enum.map(fn present ->
      present
      |> String.split("x")
      |> Enum.map(&String.to_integer/1)
      |> Enum.sort()
    end)
  end
end
