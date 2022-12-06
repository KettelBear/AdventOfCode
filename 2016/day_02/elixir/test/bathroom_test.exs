defmodule BathroomTest do
  use ExUnit.Case
  doctest Bathroom

  test "greets the world" do
    assert Bathroom.part1() == "47978"
  end

  test "greets the earth" do
    assert Bathroom.part2() == "659AD"
  end
end
