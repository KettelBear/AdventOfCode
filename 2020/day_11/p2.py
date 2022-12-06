from tools import get_input


def is_seat_occupied(i, j, delta_i, delta_j, seat_map):
    # Add right away, so we don't compare against the seat being checked.
    i += delta_i
    j += delta_j

    # While we're on the seat map.
    while (-1 < i < len(seat_map)) and (-1 < j < len(seat_map[0])):
        if seat_map[i][j] == '#':
            return True
        elif seat_map[i][j] == 'L':
            return False

        i += delta_i
        j += delta_j

    return False


def is_nw_occupied(i, j, seat_map):
    return is_seat_occupied(i, j, -1, -1, seat_map)


def is_ne_occupied(i, j, seat_map):
    return is_seat_occupied(i, j, -1, 1, seat_map)


def is_se_occupied(i, j, seat_map):
    return is_seat_occupied(i, j, 1, 1, seat_map)


def is_sw_occupied(i, j, seat_map):
    return is_seat_occupied(i, j, 1, -1, seat_map)


def is_w_occupied(i, j, seat_map):
    return is_seat_occupied(i, j, 0, -1, seat_map)


def is_e_occupied(i, j, seat_map):
    return is_seat_occupied(i, j, 0, 1, seat_map)


def is_n_occupied(i, j, seat_map):
    return is_seat_occupied(i, j, -1, 0, seat_map)


def is_s_occupied(i, j, seat_map):
    return is_seat_occupied(i, j, 1, 0, seat_map)


def can_sit(i, j, seat_map):
    if is_n_occupied(i, j, seat_map):
        return False
    if is_e_occupied(i, j, seat_map):
        return False
    if is_s_occupied(i, j, seat_map):
        return False
    if is_w_occupied(i, j, seat_map):
        return False
    if is_nw_occupied(i, j, seat_map):
        return False
    if is_ne_occupied(i, j, seat_map):
        return False
    if is_sw_occupied(i, j, seat_map):
        return False
    if is_se_occupied(i, j, seat_map):
        return False

    return True


def should_empty(i, j, seat_map):
    count = 0
    if is_n_occupied(i, j, seat_map):
        count += 1
    if is_e_occupied(i, j, seat_map):
        count += 1
    if is_s_occupied(i, j, seat_map):
        count += 1
    if is_w_occupied(i, j, seat_map):
        count += 1
    if is_nw_occupied(i, j, seat_map):
        count += 1
    if is_ne_occupied(i, j, seat_map):
        count += 1
    if is_sw_occupied(i, j, seat_map):
        count += 1
    if is_se_occupied(i, j, seat_map):
        count += 1

    return count > 4


def build_next_seat_map(seat_map):
    next_seats = []
    for i in range(len(seat_map)):
        next_seats.append([])
        for j in range(len(seat_map[0])):
            if seat_map[i][j] == '.':
                # If it is a floor, just put a floor down
                next_seats[i].append('.')
            elif seat_map[i][j] == 'L':
                next_seats[i].append('#') \
                    if can_sit(i, j, seat_map) \
                    else next_seats[i].append('L')
            else:
                next_seats[i].append('L') \
                    if should_empty(i, j, seat_map) \
                    else next_seats[i].append('#')

    return next_seats


def count_seats_occupied(seat_map):
    count = 0
    for row in seat_map:
        count += row.count('#')

    return count


def find_seat_equilibrium():
    seat_map = get_input()

    while True:
        next_seats = build_next_seat_map(seat_map)

        if next_seats == seat_map:
            break
        else:
            seat_map = next_seats

    return count_seats_occupied(seat_map)


print(find_seat_equilibrium())
