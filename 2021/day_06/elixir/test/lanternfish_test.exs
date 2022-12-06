defmodule LanternfishTest do
  use ExUnit.Case
  doctest Lanternfish

  test "Counts the lanternfish after 80 days" do
    assert Lanternfish.part1() == 374927
  end

  test "Counts the lanternfish after 256 days" do
    assert Lanternfish.part2() == 1687617803407
  end
end

