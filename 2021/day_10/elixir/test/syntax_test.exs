defmodule SyntaxTest do
  use ExUnit.Case
  doctest Syntax

  test "Calculates syntax score for bad lines" do
    assert Syntax.part1() == 339477
  end

  test "Calculates syntax score for unfinished lines" do
    assert Syntax.part2() == 3049320156
  end
end
