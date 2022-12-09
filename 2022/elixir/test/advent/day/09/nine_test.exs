defmodule Advent.Day.NineTest do
  use ExUnit.Case

  alias Advent.Day.Nine

  describe "Day 9 code" do
    test "solves part 1" do
      assert Nine.part1() == 5513
    end

    test "solves part 2" do
      assert Nine.part2() == 2427
    end
  end
end
