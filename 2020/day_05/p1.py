from tools import get_input, first_half_of, last_half_of, get_seat_id


def max_boarding_pass_id() -> int:
    '''
    First, we find the seat, then calculate the ID
    of the seat. Then we just keep track of the max
    ID found, and finally return it at the end.
    '''
    boarding_passes = get_input()

    current_max = -1
    for bp in boarding_passes:
        row = bp[:7]
        col = bp[7:]

        row = int(row.replace('F', '0').replace('B', '1'), 2)
        col = int(col.replace('L', '0').replace('R', '1'), 2)

        current_max = max(current_max, get_seat_id(row, col))

    return current_max


print(max_boarding_pass_id())
