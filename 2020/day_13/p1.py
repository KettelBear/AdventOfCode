from math import floor
from tools import get_input


def find_best_bus():
    values = get_input()

    busses = values[1].split(',')
    bus_numbers = []
    for bus in busses:
        if bus.isdigit():
            bus_numbers.append(int(bus))

    time_val = int(values[0])
    best_time = 1_000_000_000
    best_bus = 0

    for bus in bus_numbers:
        bus_start = (floor(time_val / bus) + 1) * bus
        if bus_start < best_time:
            best_time = bus_start
            best_bus = bus

    return (best_time - time_val) * best_bus


results = find_best_bus()

print('Puzzle Answer: ', results)
