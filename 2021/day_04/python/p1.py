from tools import get_input


def get_clean_boards(janky_boards):
    clean_boards = []

    splits = []
    for jank in janky_boards:
        splits.append(jank.split('\n'))

    string_boards = []
    for board in splits:
        clean = []
        for row in board:
            clean.append(row.split())

        string_boards.append(clean)

    for board in string_boards:
        clean_board = []
        for row in board:
            clean_row = []
            for num in row:
                clean_row.append((int(num), False))
            clean_board.append(clean_row)
        clean_boards.append(clean_board)

    return clean_boards


def call_number(boards, num):
    for board in boards:
        for row in board:
            for i in range(len(row)):
                if row[i][0] == num:
                    row[i] = (num, True)

    return boards


def clean_calling_numbers(csv):
    values = csv.split(',')

    return [int(x) for x in values]


def check_rows(board):
    for row in board:
        if row[0][1] and row[1][1] and row[2][1] and row[3][1] and row[4][1]:
            return True

    return False


def check_columns(board):
    columns_as_rows = zip(*board)

    return check_rows(columns_as_rows)


def check_for_winner(boards):
    for i in range(len(boards)):
        if check_rows(boards[i]) or check_columns(boards[i]):
            return i

    return -1


def solution():
    bingo = get_input("input.prod").split('\n\n')
    drawn_nums = clean_calling_numbers(bingo[0])

    playing_boards = get_clean_boards(bingo[1:])

    for i in range(4):
        playing_boards = call_number(playing_boards, drawn_nums[i])

    winner = -1
    last_number_called = -1
    for num in drawn_nums[4:]:
        playing_boards = call_number(playing_boards, num)

        winner = check_for_winner(playing_boards)
        if winner > -1:
            last_number_called = num
            break

    winning_board = playing_boards[winner]

    sum_ = 0
    for row in winning_board:
        for num in row:
            if not num[1]:
                sum_ += num[0]

    return sum_ * last_number_called


print(solution())
