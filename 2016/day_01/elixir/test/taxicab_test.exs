defmodule TaxicabTest do
  use ExUnit.Case
  doctest Taxicab

  test "Determines location of Easter Bunny HQ" do
    assert Taxicab.part1() == 262
  end

  test "Does part 2" do
    assert Taxicab.part2() == 131
  end
end
