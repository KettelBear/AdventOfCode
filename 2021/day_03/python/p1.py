from tools import get_input


def solution():
    diagnostics = get_input("input.prod")

    data = []
    for diag in diagnostics:
        data.append([char for char in diag])

    report = [list(x) for x in zip(*data)]

    gamma = ''
    epsilon = ''
    for r in report:
        if r.count('1') > r.count('0'):
            gamma += '1'
            epsilon += '0'
        else:
            gamma += '0'
            epsilon += '1'

    return int(gamma, 2) * int(epsilon, 2)


print(solution())
