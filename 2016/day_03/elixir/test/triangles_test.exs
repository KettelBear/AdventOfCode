defmodule TrianglesTest do
  use ExUnit.Case
  doctest Triangles

  test "greets the world" do
    assert Triangles.part1() == 993
  end

  test "greets the earth" do
    assert Triangles.part2() == 1849
  end
end
