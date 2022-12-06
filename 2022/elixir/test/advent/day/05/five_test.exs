defmodule Advent.Day.FiveTest do
  use ExUnit.Case

  alias Advent.Day.Five

  describe "Day 5 code" do
    test "solves part 1" do
      assert Five.part1() == "VPCDMSLWJ"
    end

    test "solves part 2" do
      assert Five.part2() == "TPWCGNCCG"
    end
  end
end
