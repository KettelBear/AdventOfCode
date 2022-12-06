from os.path import dirname, realpath, join


def get_input() -> list:
    dir_path = dirname(realpath(__file__))
    with open(join(dir_path, "input.txt"), "r") as infile:
        report = infile.read().splitlines()
    return report


def first_half_of(list_: list) -> list:
    '''
    Return the first half of the list passed in.
    '''
    return list_[:int(len(list_)/2)]


def last_half_of(list_: list) -> list:
    '''
    Return the last half of the list passed in. 
    '''
    return list_[int(len(list_)/2):]


def get_seat_id(row: int, column: int) -> int:
    '''
    The formula for calculating the seat ID.
    '''
    return row * 8 + column
