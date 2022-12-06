from tools import get_input


def solution():
    fish = get_input("input.prod")

    for day in range(80):
        for i in range(len(fish)):
            fish[i] -= 1

            if fish[i] == -1:
                fish[i] = 6
                fish.append(8)

    return len(fish)


print(solution())
