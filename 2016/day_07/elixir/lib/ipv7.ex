defmodule Ipv7 do
  @moduledoc """
  While snooping around the local network of EBHQ, you compile a list of IP
  addresses (they're IPv7, of course; IPv6 is much too limited). You'd like to
  figure out which IPs support TLS (transport-layer snooping).
  An IP supports TLS if it has an Autonomous Bridge Bypass Annotation, or ABBA.
  An ABBA is any four-character sequence which consists of a pair of two
  different characters followed by the reverse of that pair, such as xyyx or
  abba. However, the IP also must not have an ABBA within any hypernet
  sequences, which are contained by square brackets.
  """

  @hypernet ~r/\[([a-z]+)\]/

  @doc """
  How many IPs in your puzzle input support TLS?
  """
  def part1, do: parse_input("input.prod") |> Enum.count(&tls?/1)

  defp tls?(ip) do
    ip
    |> get_hypernets()
    |> get_supernets(ip)
    |> check_abba?()
  end

  defp check_abba?({hypers, supers}) do
    !Enum.any?(hypers, &abba?/1) and Enum.any?(supers, &abba?/1)
  end

  defp abba?([]), do: false
  defp abba?([a, b, b, a | _rest]) when a != b, do: true
  defp abba?([_ | rest]), do: abba?(rest)
  defp abba?(chars), do: chars |> String.graphemes() |> abba?()

  @doc """
  You would also like to know which IPs support SSL (super-secret listening).
  An IP supports SSL if it has an Area-Broadcast Accessor, or ABA, anywhere in
  the supernet sequences (outside any square bracketed sections), and a
  corresponding Byte Allocation Block, or BAB, anywhere in the hypernet
  sequences. An ABA is any three-character sequence which consists of the same
  character twice with a different character between them, such as xyx or aba.
  A corresponding BAB is the same characters but in reversed positions: yxy and
  bab, respectively.
  How many IPs in your puzzle input support SSL?
  """
  def part2, do: parse_input("input.prod") |> Enum.count(&ssl?/1)

  defp ssl?(ip) do
    ip
    |> get_hypernets()
    |> get_supernets(ip)
    |> check_ssl?()
  end

  defp check_ssl?({hypers, supers}) do
    supers
    |> find_all_aba()
    |> Enum.any?(&(hypers_contain_bab?(hypers, &1)))
  end

  defp hypers_contain_bab?(hypers, [a, b]) do
    Enum.any?(hypers, &(String.contains?(&1, b <> a <> b)))
  end

  defp find_all_aba(supers) do
    supers
    |> Enum.map(&String.graphemes/1)
    |> Enum.reduce([], &scan_sub_addr/2)
  end

  defp scan_sub_addr(sub_super_chars, aba_collection) do
    sub_super_chars
    |> Enum.chunk_every(3, 1, :discard)
    |> Enum.reduce([], fn
      [a, b, a], acc when a != b -> [[a, b] | acc]
      _, acc -> acc
    end)
    |> Kernel.++(aba_collection)
  end

  defp get_hypernets(ip) do
    @hypernet
    |> Regex.scan(ip)
    |> Enum.map(fn [_match, group] -> group end)
  end

  defp get_supernets(hypers, ip) do
    ip
    |> String.split(hypers, trim: true)
    |> Enum.map(&String.replace(&1, ["[", "]"], ""))
    |> then(&({hypers, &1}))
  end

  defp parse_input(file) do
    file
    |> File.read!()
    |> String.split(["\n", "\r\n"], trim: true)
  end
end
