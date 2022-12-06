defmodule SignalsTest do
  use ExUnit.Case
  doctest Signals

  test "greets the world" do
    assert Signals.part1() == "umcvzsmw"
  end

  test "greets the earth" do
    assert Signals.part2() == "rwqoacfz"
  end
end
