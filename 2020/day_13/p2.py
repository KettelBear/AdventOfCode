from math import floor, prod
from tools import get_input


def compute_gcd(x, y):
    while(y):
        x, y = y, x % y
    return x


def compute_lcm(x, y):
    lcm = (x*y)//compute_gcd(x, y)
    return lcm


def parse_input(values):
    busses = values[1].split(',')
    bus_nums = {}
    delta = 0
    for bus in busses:
        if bus.isdigit():
            bus_nums[int(bus)] = delta
        delta += 1

    return bus_nums


def find_sequence_of_bus_departures():
    '''
    Using some prime number magic, because we looked at the
    input and saw they were prime, we can utilize this least
    common multiple (LCM) increment trick to find the starting
    number where the first bus in the list leaves at that time
    and each subsequent bus leaves at the delta time after the
    start time.
    '''
    bus_nums = parse_input(get_input())
    print(bus_nums)

    busses = list(bus_nums.keys())
    start = busses[0]
    some_lcm = busses[0]
    for bus in busses:
        while (start + bus_nums[bus]) % bus != 0:
            start += some_lcm
        some_lcm = compute_lcm(bus, some_lcm)

    return start

    # Below is an attempt at Chinese Remainder Theorem
    # that I just could not implement.

    # busses = values[1].split(',')
    # busses = busses[1:]
    # bus_nums = {}
    # delta = 0
    # for s in busses:
    #     try:
    #         val = int(s)
    #         bus_nums[val] = val - delta
    #     except:
    #         pass
    #     delta += 1

    # print(bus_nums)

    # N = prod(list(bus_nums.keys()))

    # b_i = list(bus_nums.values())
    # N_i = []
    # x_i = []
    # for key in bus_nums.keys():
    #     n = int(N / key)
    #     N_i.append(n)
    #     x = n % key
    #     counter = x
    #     mod = 0
    #     while True:
    #         if mod == 1:
    #             break
    #         counter += x
    #         mod = counter % key
    #     x_i.append(counter)

    # print("N_i: ", N_i)
    # print("x_i: ", x_i)
    # print("b_i: ", b_i)
    # sum_ = 0
    # for itr in range(len(N_i)):
    #     sum_ += (b_i[itr] * N_i[itr] * x_i[itr])

    # return sum_ % N


results = find_sequence_of_bus_departures()

print('Puzzle Answer: ', results)
