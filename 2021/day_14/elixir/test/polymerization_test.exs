defmodule PolymerizationTest do
  use ExUnit.Case
  doctest Polymerization

  test "The difference after 10 steps" do
    assert Polymerization.part1() == 2657
  end

  test "The difference after 40 steps" do
    assert Polymerization.part2() == 2_911_561_572_630
  end
end
