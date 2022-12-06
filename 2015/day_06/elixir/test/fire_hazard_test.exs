defmodule FireHazardTest do
  use ExUnit.Case
  doctest FireHazard

  test "After following the instructions, how many lights are lit?" do
    assert FireHazard.part1() == 569999
  end

  test "What is the total brightness of all lights combined after following Santa's instructions?" do
    assert FireHazard.part2() == 17836115
  end
end
