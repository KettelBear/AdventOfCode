defmodule TrickShotTest do
  use ExUnit.Case
  doctest TrickShot

  test "The highest y position it reaches on trajectory" do
    assert TrickShot.part1() == 5778
  end

  test "Don't know yet" do
    assert TrickShot.part2() == 2576
  end
end
