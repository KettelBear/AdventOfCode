from tools import get_input


def is_one_most_common(diagnostics, position):
    data = []
    for diag in diagnostics:
        data.append([char for char in diag])

    # Inverse the 2d array, so that it is easy to count frequency
    report = [list(x) for x in zip(*data)]

    return report[position].count('1') >= report[position].count('0')


def get_reading(data, is_oxygen):
    reading = 0
    for i in range(len(data[0])):
        filter_bit = '1' if is_one_most_common(data, i) else '0'
        if not is_oxygen:
            filter_bit = '0' if filter_bit == '1' else '1'
        data = list(filter(lambda x: x[i] == filter_bit, data))
        if len(data) == 1:
            reading = int(data[0], 2)
            break

    return reading


def solution():
    diagnostics = get_input('input.prod')

    return get_reading(diagnostics, True) * get_reading(diagnostics, False)


print(solution())
