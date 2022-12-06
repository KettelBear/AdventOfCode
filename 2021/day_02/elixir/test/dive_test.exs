defmodule DiveTest do
  use ExUnit.Case
  doctest Dive

  test "Follows instructions and dives" do
    assert Dive.part1() == 1654760
  end

  test "Follows instructions, adjusting aim, and diving" do
    assert Dive.part2() == 1956047400
  end
end
