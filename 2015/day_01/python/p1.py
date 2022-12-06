from tools import get_input

def solution():
  parens = get_input("input.prod")

  return parens.count("(") - parens.count(")")


print(solution())