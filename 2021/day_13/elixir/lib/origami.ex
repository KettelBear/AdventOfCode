defmodule Origami do
  def part1() do
    {points, instructions} = parse_input("input.prod")

    paper = draw_points(points)
    instructions = parse_instructions(instructions)

    instructions
    |> Enum.take(1)
    |> Enum.reduce(paper, fn {dir, line}, paper ->
      Enum.map(paper, fold(dir, line))
    end)
    |> Enum.uniq()
    |> length()
  end

  def part2() do
    {points, instructions} = parse_input("input.prod")

    paper = draw_points(points)
    instructions = parse_instructions(instructions)

    folded =
      Enum.reduce(instructions, paper, fn {dir, line}, paper ->
        Enum.map(paper, fold(dir, line))
      end)

    {width, _} = Enum.max_by(folded, &elem(&1, 0))
    {_, height} = Enum.max_by(folded, &elem(&1, 1))

    grid = MapSet.new(folded)

    for y <- 0..height do
      for x <- 0..width do
        if {x, y} in grid do
          IO.write(" \u2588 ")
        else
          IO.write("   ")
        end
      end
      IO.puts("")
    end

    true
  end

  defp draw_points(points) do
    Enum.map(points, fn point ->
      [x, y] = point |> Enum.map(&String.to_integer/1)
      {x, y}
    end)
  end

  defp parse_instructions(instructions) do
    Enum.map(instructions, fn [dir, line] ->
      {String.to_atom(dir), String.to_integer(line)}
    end)
  end

  defp fold(:x, line), do: fn {x, y} -> {line - abs(x - line), y} end
  defp fold(:y, line), do: fn {x, y} -> {x, line - abs(y - line)} end

  defp parse_input(in_file) do
    [points_raw, instr_raw ] =
      File.read!(in_file)
      |> String.split("\n\n", trim: true)

    points =
      points_raw
      |> String.split("\n", trim: true)
      |> Enum.map(fn value -> value |> String.split(",") end)

    instructions =
      instr_raw
      |> String.split("\n", trim: true)
      |> Enum.map(fn "fold along " <> inst -> inst |> String.split("=") end)

    {points, instructions}
  end
end
