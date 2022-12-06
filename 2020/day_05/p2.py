from tools import get_input, first_half_of, last_half_of, get_seat_id


def get_passes_sorted() -> list:
    '''
    Similar to Part 1 of Day 5, we gather all the IDs
    in a list instead of just keeping track of the max.
    Then, we'll sort the list.
    '''
    boarding_passes = get_input()

    board_pass_ids = []
    for bp in boarding_passes:
        row = bp[:7]
        col = bp[7:]

        row = int(row.replace('F', '0').replace('B', '1'), 2)
        col = int(col.replace('L', '0').replace('R', '1'), 2)

        board_pass_ids.append(get_seat_id(row, col))

    board_pass_ids.sort()

    return board_pass_ids


def get_my_seat() -> int:
    '''
    We were told that our seat is the only empty one,
    and we're somewhere in the middle, and that IDs +1
    and -1 (each side of us) is taken. Just iterate
    through the sorted IDs until we find one where the
    +1 is missing, that is our seat.
    '''
    board_pass_ids = get_passes_sorted()

    for pi in board_pass_ids:
        if pi + 1 not in board_pass_ids:
            return pi + 1

    return board_pass_ids


print(get_my_seat())
