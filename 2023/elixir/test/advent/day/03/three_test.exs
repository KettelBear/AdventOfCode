defmodule Advent.Day.ThreeTest do
  use ExUnit.Case

  alias Advent.Day.Three

  describe "Day 3 code" do
    test "solves part 1" do
      assert Three.part1() == 537_832
    end

    test "solves part 2" do
      assert Three.part2() == 81_939_900
    end
  end
end
