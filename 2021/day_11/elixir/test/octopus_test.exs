defmodule OctopusTest do
  use ExUnit.Case
  doctest Octopus

  test "Counts the number of flashes after 100 steps" do
    assert Octopus.part1() == 1649
  end

  test "Counts the number of steps when all octopi flash in sync" do
    assert Octopus.part2() == 256
  end
end
