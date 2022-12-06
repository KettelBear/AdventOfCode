from tools import get_input
from time import sleep

point_map = dict({')': 3, ']': 57, '}': 1197, '>': 25137})
closer_lookup = dict({'(': ')', '[': ']', '{': '}', '<': '>'})


def solution():
    nav_reading = get_input('input.prod')

    bad_closers = dict({')': 0, ']': 0, '}': 0, '>': 0})
    for line in nav_reading:
        closer_stack = list()

        for char in line:
            if char in ['(', '[', '{', '<']:
                closer_stack.append(closer_lookup[char])
            elif char == closer_stack[-1]:
                closer_stack.pop()
            else:
                bad_closers[char] += 1
                break

    sum_ = 0
    for k, v in bad_closers.items():
        sum_ += point_map[k] * v

    return sum_


print(solution())
