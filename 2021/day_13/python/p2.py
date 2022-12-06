from tools import get_input


def place_initial(points):
    max_x = 0
    max_y = 0
    coords = set()
    for point in points.split("\n"):
        x, y = [int(v) for v in point.split(",")]
        max_x = max(x, max_x)
        max_y = max(y, max_y)
        coords.add((x, y))

    paper = list()
    for y in range(max_y + 1):
        row = list()
        for x in range(max_x + 1):
            row.append(u"\u2588" if (x,y) in coords else " ")
        paper.append(row)

    return paper


def parse_instructions(instructions):
    instr_set = list()

    for instr in instructions.split("\n"):
        fold, line = instr.split("=")
        instr_set.append((fold[-1], int(line)))

    return instr_set


def fold_up(paper, line):
    folded = paper[0:line]
    move = paper[line+1:]

    size = len(move)

    for y in range(size):
        for x in range(len(move[0])):
            offset = size - 1 - y
            if folded[offset][x] == " ":
                folded[offset][x] = move[y][x]

    return folded


def fold_left(paper, line):
    for y in range(len(paper)):
        paper[y] = fold_row_left(paper[y], line)

    return paper


def fold_row_left(row, line):
    folded = row[0:line]
    move = row[line+1:]

    size = len(move)

    for x in range(size):
        offset = size - 1 - x
        if folded[offset] == " ":
            folded[offset] = move[x]

    return folded


def follow_instructions(paper, instructions):
    for (fold, line) in instructions:
        paper = fold_up(paper, line) if fold == "y" else fold_left(paper, line)

    return paper


def print_paper(paper):
    for row in paper:
        print(row)


def solution():
    initial_points, instructions = get_input("input.prod").split("\n\n")

    paper = place_initial(initial_points)
    instr_set = parse_instructions(instructions)

    paper = follow_instructions(paper, instr_set)

    return paper


if __name__ == "__main__":
    print_paper(solution())
