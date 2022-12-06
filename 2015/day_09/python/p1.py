import itertools
from tools import get_input

def generate_dist_map():
  data = get_input("input.prod")

  dist_map = {}
  city_col = []
  for datum in data:
    [cities, distance] = datum.split(' = ')
    [city1, city2] = cities.split(' to ')

    # Add cities to distance map, both ways.
    dist_map[cities] = int(distance)
    dist_map[city2 + " to " + city1] = int(distance)

    # Ensure I have each city in my city collection
    if city1 not in city_col:
      city_col.append(city1)
    if city2 not in city_col:
      city_col.append(city2)

  return city_col, dist_map


def solution():
  cities, dist_map = generate_dist_map()

  # Put together each possible path. All iterations
  all_routes = [list(x) for x in itertools.permutations(cities)]

  # Iterate through each possible route, and sum distances, keeping track of shortest.
  shortest = 9999999
  for route in all_routes:
    sum_ = 0
    for i in range(len(route) - 1):
      sum_ += dist_map[route[i] + " to " + route[i + 1]]

    if sum_ < shortest:
      shortest = sum_

  return shortest


print(solution())