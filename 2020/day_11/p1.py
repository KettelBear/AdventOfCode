from tools import get_input


def can_sit(i, j, seat_map):
    '''
    I cleaned these up in part 2. I'm not cleaning it up here.
    '''
    try:
        if i < 1 or j < 1:
            pass
        elif seat_map[i-1][j-1] == '#':
            return False
    except:
        pass

    try:
        if i < 1:
            pass
        elif seat_map[i-1][j] == '#':
            return False
    except:
        pass

    try:
        if i < 1:
            pass
        elif seat_map[i-1][j+1] == '#':
            return False
    except:
        pass

    try:
        if j < 1:
            pass
        elif seat_map[i][j-1] == '#':
            return False
    except:
        pass

    try:
        if seat_map[i][j+1] == '#':
            return False
    except:
        pass

    try:
        if j < 1:
            pass
        elif seat_map[i+1][j-1] == '#':
            return False
    except:
        pass

    try:
        if seat_map[i+1][j] == '#':
            return False
    except:
        pass

    try:
        if seat_map[i+1][j+1] == '#':
            return False
    except:
        pass

    return True


def should_empty(i, j, seat_map):
    '''
    I cleaned these up in part 2. I'm not cleaning it up here.
    '''
    count = 0
    try:
        if i < 1 or j < 1:
            pass
        elif seat_map[i-1][j-1] == '#':
            count += 1
    except:
        pass

    try:
        if i < 1:
            pass
        elif seat_map[i-1][j] == '#':
            count += 1
    except:
        pass

    try:
        if i < 1:
            pass
        elif seat_map[i-1][j+1] == '#':
            count += 1
    except:
        pass

    try:
        if j < 1:
            pass
        elif seat_map[i][j-1] == '#':
            count += 1
    except:
        pass

    try:
        if seat_map[i][j+1] == '#':
            count += 1
    except:
        pass

    try:
        if j < 1:
            pass
        elif seat_map[i+1][j-1] == '#':
            count += 1
    except:
        pass

    try:
        if seat_map[i+1][j] == '#':
            count += 1
    except:
        pass

    try:
        if seat_map[i+1][j+1] == '#':
            count += 1
    except:
        pass

    return count > 3


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


def day_11():
    seat_map = get_input()

    while True:
        next_seats = build_next_seat_map(seat_map)

        if next_seats == seat_map:
            break
        else:
            seat_map = next_seats

    return count_seats_occupied(seat_map)


results = day_11()

print(results)
