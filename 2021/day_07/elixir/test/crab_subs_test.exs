defmodule CrabSubsTest do
  use ExUnit.Case
  doctest CrabSubs

  test "Calculates crab fuel" do
    assert CrabSubs.part1() == 328187
  end

  test "Calculates sum of consecutive numbers for crab fuel" do
    assert CrabSubs.part2() == 91257582
  end
end
