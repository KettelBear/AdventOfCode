defmodule BasinTest do
  use ExUnit.Case
  doctest Basin

  test "Sums the risk levels of low points" do
    assert Basin.part1() == 444
  end

  test "Finds the product of the 3 largest basins" do
    assert Basin.part2() == 1168440
  end
end
