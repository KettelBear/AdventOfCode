defmodule Triangles do
  @moduledoc """
  Now that you can think clearly, you move deeper into the labyrinth of hallways
  and office furniture that makes up this part of Easter Bunny HQ. This must be
  a graphic design department; the walls are covered in specifications for
  triangles.
  Or are they?
  The design document gives the side lengths of each triangle it describes,
  but... 5 10 25? Some of these aren't triangles. You can't help but mark the
  impossible ones.
  In a valid triangle, the sum of any two sides must be larger than the
  remaining side. For example, the "triangle" given above is impossible,
  because 5 + 10 is not larger than 25.
  """

  @doc """
  How many of the listed triangles are possible?
  """
  def part1(), do: parse_input("input.prod") |> Enum.count(&valid_triangle?/1)

  @doc """
  Now that you've helpfully marked up their design documents, it occurs to you
  that triangles are specified in groups of three vertically. Each set of three
  numbers in a column specifies a triangle. Rows are unrelated.
  In your puzzle input, and instead reading by columns, how many of the listed
  triangles are possible?
  """
  def part2(), do: parse_input("input.prod") |> format_data() |> Enum.count(&valid_triangle?/1)

  defp format_data(data) do
    data
    |> Enum.chunk_every(3)
    |> Enum.map(&Enum.zip/1)
    |> List.flatten()
  end

  defp valid_triangle?({a, b, c}), do: satisfies_theorem?(a, b, c)
  defp valid_triangle?([a, b, c]), do: satisfies_theorem?(a, b, c)

  defp satisfies_theorem?(a, b, c) do
    if a > b do
      if a > c, do: b + c > a, else: b + a > c
    else
      if b > c, do: a + c > b, else: a + b > c
    end
  end

  defp parse_input(file) do
    file
    |> File.read!()
    |> String.split(["\n", "\r\n"], trim: true)
    |> Enum.map(fn sides ->
      sides
      |> String.split(" ", trim: true)
      |> Enum.map(&String.to_integer/1)
    end)
  end
end
