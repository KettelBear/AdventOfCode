from tools import get_input
import re


def parse_rules(rules):
    rules = rules.split('\n')

    vals = {}
    for rule in rules:
        match = re.match(r'^([a-z ]+):.* (\d+)-(\d+) or (\d+)-(\d+)$', rule)
        vals[match.group(1)] = {
            'low': (int(match.group(2)), int(match.group(3))),
            'high': (int(match.group(4)), int(match.group(5)))
        }
    return vals


def filter_tickets(rules, tickets):
    valid = []
    for ticket in tickets:
        t = True
        numbers = [int(n) for n in ticket.split(',')]
        for number in numbers:
            v = False
            for rule in rules.values():
                if (rule['low'][0] < number < rule['low'][1]) \
                        or (rule['high'][0] < number < rule['high'][1]):
                    v = True
                    break
            if not v:
                t = False
        if t:
            valid.append([int(n) for n in ticket.split(',')])
    return valid


def determine_columns(rules, valid_tickets):
    possibles = {}

    some_len = len(valid_tickets[0])

    for i in range(some_len):
        possibles[i] = list(rules.keys())

    for itr in range(some_len):
        for ticket in valid_tickets:
            for column, rng in rules.items():
                val = ticket[itr]
                if not (rng['low'][0] <= val <= rng['low'][1]) \
                        and not (rng['high'][0] <= val <= rng['high'][1]):
                    possibles[itr].remove(column)

    column = 0
    item = ''
    for col, row in possibles.items():
        if len(row) == 1:
            column = col
            item = row[0]

    return recurse_removal(possibles, item, column)


def recurse_removal(dict, item, skip):
    next_col = 0
    next_item = ''
    for col, row in dict.items():
        if col == skip:
            continue
        if len(row) == 1:
            continue
        row.remove(item)
        if len(row) == 1:
            next_col = col
            next_item = row[0]

    if next_item == '':
        return dict

    return recurse_removal(dict, next_item, next_col)


def day_16():
    groups = get_input().split('\n\n')

    rules = parse_rules(groups[0])

    my_ticket = [int(n) for n in groups[1].split('\n')[1].split(',')]
    other_tickets = groups[2].split('\n')[1:-1]

    other_tickets = filter_tickets(rules, other_tickets)

    column_map = determine_columns(rules, other_tickets)

    product = 1
    for col, name in column_map.items():
        if 'departure' in name.pop():
            product *= my_ticket[col]

    return product


results = day_16()

print('Puzzle Answer: ', results)
