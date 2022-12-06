from tools import get_input
import re


def parse_rules(rules):
    rules = rules.split('\n')

    vals = set()
    for rule in rules:
        print('Rule:', rule)
        match = re.match(r'^.* (\d+)-(\d+) or (\d+)-(\d+)$', rule)
        for i in range(int(match.group(1)), int(match.group(2)) + 1):
            vals.add(i)
        for i in range(int(match.group(3)), int(match.group(4)) + 1):
            vals.add(i)

    return vals


def sum_invalid_ticket_values(rules, tickets):
    tickets.pop()  # Remove empty newline
    sum_ = 0
    for ticket in tickets:
        numbers = [int(n) for n in ticket.split(',')]
        for number in numbers:
            if number not in rules:
                sum_ += number

    return sum_


def day_16():
    groups = get_input().split('\n\n')

    rules = parse_rules(groups[0])

    return sum_invalid_ticket_values(rules, groups[2].split('\n')[1:])


results = day_16()

print('Puzzle Answer: ', results)
