defmodule Decoder do
  def part1(), do: parse_input() |> to_tree() |> count_versions()
  def part2(), do: parse_input() |> to_tree() |> eval()


  defp decode_hex(<<>>), do: <<>>
  defp decode_hex(<<a, b, r::binary>>) do
    :binary.encode_unsigned(elem(Integer.parse(<<a, b>>, 16), 0)) <> decode_hex(r)
  end

  defp bits_to_int(bits) do
    s = bit_size(bits)
    <<int::size(s)>> = bits
    int
  end

  defp parse_package(bits) do
    {v, tl} = parse_version(bits)
    {inner, tl} = parse(tl)
    {{v, inner}, tl}
  end

  defp parse_packages(<<>>), do: []
  defp parse_packages(bits) do
    {p, tl} = parse_package(bits)
    [p | parse_packages(tl)]
  end

  defp parse_n_packages(tl, 0), do: {[], tl}
  defp parse_n_packages(bits, n) do
    {p, tl} = parse_package(bits)
    {ps, tl} = parse_n_packages(tl, n - 1)
    {[p | ps], tl}
  end

  defp parse(<<4::3, tl::bits>>), do: parse_literal(tl)
  defp parse(<<o::3, tl::bits>>), do: parse_operator(tl, o)

  defp parse_version(<<v::3, tl::bits>>), do: {v, tl}

  defp parse_literal(bits), do: parse_literal(bits, <<>>)
  defp parse_literal(<<0::1, b::4, tl::bits>>, res), do: {bits_to_int(<<res::bits, b::4>>), tl}
  defp parse_literal(<<1::1, b::4, tl::bits>>, res), do: parse_literal(tl, <<res::bits, b::4>>)

  defp parse_operator(<<0::1, size::15, sub::size(size), tl::bits>>, op) do
    {{op, parse_packages(<<sub::size(size)>>)}, tl}
  end
  defp parse_operator(<<1::1, amount::11, tl::bits>>, op) do
    {operands, tl} = parse_n_packages(tl, amount)
    {{op, operands}, tl}
  end

  defp count_versions(n) when is_number(n), do: 0
  defp count_versions({_, l}) when is_list(l), do: l |> Enum.map(&count_versions/1) |> Enum.sum()
  defp count_versions({v, p}), do: v + count_versions(p)

  defp eval(n) when is_number(n), do: n
  defp eval({0, lst}) when is_list(lst), do: lst |> Enum.map(&eval/1) |> Enum.sum()
  defp eval({1, lst}) when is_list(lst), do: lst |> Enum.map(&eval/1) |> Enum.product()
  defp eval({2, lst}) when is_list(lst), do: lst |> Enum.map(&eval/1) |> Enum.min()
  defp eval({3, lst}) when is_list(lst), do: lst |> Enum.map(&eval/1) |> Enum.max()
  defp eval({5, [l, r]}), do: if(eval(l) > eval(r), do: 1, else: 0)
  defp eval({6, [l, r]}), do: if(eval(l) < eval(r), do: 1, else: 0)
  defp eval({7, [l, r]}), do: if(eval(l) == eval(r), do: 1, else: 0)
  defp eval({_version, r}), do: eval(r)

  defp parse_input() do
    File.read!("input.prod")
    |> String.trim()
  end

  defp to_tree(string) do
    string
    |> decode_hex()
    |> parse_package()
    |> elem(0)
  end
end
