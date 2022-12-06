from tools import get_input

def solution():
    fishes = get_input("input.prod")
    population_map = {
        0: 0,
        1: 0,
        2: 0,
        3: 0,
        4: 0,
        5: 0,
        6: 0,
        7: 0,
        8: 0
    }

    for fish in fishes:
        population_map[fish] += 1

    for day in range(256):
        produced_fish = population_map[0]
        population_map[7] += population_map[0]
        for idx in range(1,9):
            population_map[idx-1] = population_map[idx]
        population_map[8] = produced_fish

    return sum(population_map.values())


print(solution())

