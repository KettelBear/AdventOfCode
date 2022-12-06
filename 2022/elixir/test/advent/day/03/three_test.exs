defmodule Advent.Day.ThreeTest do
  use ExUnit.Case

  alias Advent.Day.Three

  describe "Day 3 code" do
    test "solves part 1" do
      assert Three.part1() == 8185
    end

    test "solves part 2" do
      assert Three.part2() == 2817
    end
  end
end
