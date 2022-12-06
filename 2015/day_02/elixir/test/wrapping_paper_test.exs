defmodule WrappingPaperTest do
  use ExUnit.Case
  doctest WrappingPaper

  test "Total square feet of wrapping paper" do
    assert WrappingPaper.part1() == 1588178
  end

  test "Total feet of ribbon" do
    assert WrappingPaper.part2() == 3783758
  end
end
