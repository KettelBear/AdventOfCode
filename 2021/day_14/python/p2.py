from tools import get_input
from collections import Counter


def parse_rules(raw):
    rules = dict()
    for r in raw.split("\n"):
        pair, element = r.split(" -> ")
        rules[pair] = element

    return rules


def count_characters(polymer, rules):
    pair_freq = Counter()
    char_freq = Counter(polymer)

    for idx in range(len(polymer) - 1):
        pair = polymer[idx:idx+2]
        pair_freq[pair] += 1

    for _ in range(40):
        pair_step = Counter()
        for pair, freq in pair_freq.items():
            if pair in rules:
                letter = rules[pair]
                pair_step[pair[0] + letter] += freq
                pair_step[letter + pair[1]] += freq
                char_freq[letter] += freq
        pair_freq = pair_step

    return char_freq


def solution():
    polymer, rules_raw = get_input("input.prod").split("\n\n")

    rules = parse_rules(rules_raw)

    frequencies = count_characters(polymer, rules)

    return max(frequencies.values()) - min(frequencies.values())


if __name__ == "__main__":
    print(solution())
