defmodule SecurityTest do
  use ExUnit.Case
  doctest Security

  test "greets the world" do
    assert Security.part1() == 158835
  end

  test "greets the earth" do
    assert Security.part2() == 993
  end
end
