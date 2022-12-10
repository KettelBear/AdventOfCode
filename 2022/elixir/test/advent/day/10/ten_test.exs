defmodule Advent.Day.TenTest do
  use ExUnit.Case

  alias Advent.Day.Ten

  describe "Day 10 code" do
    test "solves part 1" do
      assert Ten.part1() == 13180
    end

    test "solves part 2" do
      assert Ten.part2() == "EZFCHJAB"
    end
  end
end
