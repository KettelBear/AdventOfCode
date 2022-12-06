from tools import get_input


def day_10():
    values = get_input()

    dict = {
        1: 0,
        2: 0,
        3: 0
    }
    values.sort()
    dict[values[0]] += 1
    for itr in range(len(values) - 1):
        dict[values[itr+1] - values[itr]] += 1
    dict[3] += 1
    return dict[1] * dict[3]


print(day_10())
