defmodule DecoderTest do
  use ExUnit.Case
  doctest Decoder

  test "Add up the version numbers in all packets" do
    assert Decoder.part1() == 967
  end

  test "Evaluate the expression represented by your hexadecimal-encoded BITS transmission" do
    assert Decoder.part2() == 12883091136209
  end
end
