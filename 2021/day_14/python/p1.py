from tools import get_input


def parse_rules(raw):
    rules = dict()
    for r in raw.split("\n"):
        pair, element = r.split(" -> ")
        rules[pair] = element

    return rules


def insertion(polymer, rules):
    poly = ""
    for i in range(len(polymer) - 1):
        pair = polymer[i:i+2]
        poly += pair[0] + rules[pair]

    poly += polymer[-1]

    return poly


def calc_difference(polymer):
    unique = set(polymer)

    counts = dict()
    for letter in unique:
        counts[letter] = polymer.count(letter)

    counts = list(counts.values())
    counts.sort()

    return counts[-1] - counts[0]


def solution():
    polymer, rules_raw = get_input("input.prod").split("\n\n")

    rules = parse_rules(rules_raw)

    for _ in range(10):
        polymer = insertion(polymer, rules)

    return calc_difference(polymer)


if __name__ == "__main__":
    print(solution())
