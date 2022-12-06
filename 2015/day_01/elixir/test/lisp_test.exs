defmodule LispTest do
  use ExUnit.Case
  doctest Lisp

  test "What floor does he finally land on" do
    assert Lisp.part1() == 232
  end

  test "When does he first go to the basement" do
    assert Lisp.part2() == 1783
  end
end
