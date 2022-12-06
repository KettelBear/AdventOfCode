defmodule Advent.Day.OneTest do
  use ExUnit.Case

  alias Advent.Day.One

  describe "Day 1 code" do
    test "solves part 1" do
      assert One.part1() == 69310
    end

    test "solves part 2" do
      assert One.part2() == 206104
    end
  end
end
