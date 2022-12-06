from tools import get_input

def solution():
  parens = get_input("input.prod")

  position = 0
  floor = 0
  for char in parens:
    floor += 1 if char == "(" else -1
    position += 1

    if floor == -1:
      return position


print(solution())