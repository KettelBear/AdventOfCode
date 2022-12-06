defmodule Ipv7Test do
  use ExUnit.Case

  test "greets the world" do
    assert(Ipv7.part1() >= 110)
  end

  test "greets the earth" do
    assert(Ipv7.part2() == 242)
  end
end
