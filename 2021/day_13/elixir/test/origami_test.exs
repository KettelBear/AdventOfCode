defmodule OrigamiTest do
  use ExUnit.Case
  doctest Origami

  test "Count visible dots after the first fold" do
    assert Origami.part1() == 647
  end

  test "Part 2 writes stuff to the console" do
    assert Origami.part2()
  end
end
