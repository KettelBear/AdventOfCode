defmodule PathingTest do
  use ExUnit.Case
  doctest Pathing

  test "Finds number of paths visiting small caves at most once" do
    assert Pathing.part1() == 4549
  end

  test "Finds number of paths visiting at most one small cave twice" do
    assert Pathing.part2() == 120535
  end
end
