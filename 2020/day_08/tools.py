from os.path import dirname, realpath, join


def get_input() -> list:
    dir_path = dirname(realpath(__file__))
    with open(join(dir_path, "input.txt"), "r") as infile:
        report = infile.read().splitlines()
    return report


def parse_instruction(instruction: str) -> tuple:
    instr_arr = instruction.split(' ')

    op = instr_arr[0]
    value = int(instr_arr[1])
    was_executed = len(instr_arr) == 3

    return (op, value, was_executed)
