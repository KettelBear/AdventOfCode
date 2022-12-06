from tools import get_input


def map_rules(rules):
    parsed_rules = {}
    for rule in rules:
        some = rule.split(':')
        sub_rules = some[1].split('|')
        vals = []
        for sub in sub_rules:
            r = sub.strip()
            if r == '"a"' or r == '"b"':
                vals = sub[2]
            else:
                vals.append(sub.strip())
        parsed_rules[some[0]] = vals

    return parsed_rules


def something(key, rules):
    print('Key:', key)
    value = rules[key]
    
    if value == 'a' or value == 'b':
        return value

    i = 0
    while i < len(value):
        paths = value[i].split(' ')
        j = 0
        while j < len(paths):
            paths[j] = something(paths[j], rules)
            j += 1
        print('Paths:', paths)
        try:
            value[i] = ' '.join(paths)
        except:
            break
        i += 1

    return value

    

def day_19():
    values = get_input()
    values = values.split('\n\n')

    rules = values[0].split('\n')

    rules = map_rules(rules)

    possibles = something('0', rules)
    print('Possibles:', possibles)
    return rules
    text = values[1].split('\n')

    count = 0
    for possible in rules:
        if possible in text:
            count += 1

    return count


results = day_19()

print('Puzzle Answer:', results)
