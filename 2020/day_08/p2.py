from tools import get_input, parse_instruction


def execute_program(program: list) -> int:
    '''
    Similar to part 1, this will execute the program input. However, unlike
    part 1, it will return -1 when it enters an infinite loop instead of
    returning the current accumulator value.
    '''
    accumulator = line_number = 0
    while line_number < len(program):
        (op, value, was_exected) = parse_instruction(program[line_number])

        if was_exected:
            # Porgram entered infinite loop.
            return -1

        program[line_number] += ' true'

        if op == 'acc':
            accumulator += value
            line_number += 1
        elif op == 'jmp':
            line_number += value
        else:
            line_number += 1

    return accumulator


def debug_program() -> int:
    '''
    We were told that the program bug was that exactly one operation was
    flipped, and that it was either a NOP to a JMP, or a JMP to a NOP.
    We'll iterate by line number, and for the given line in the program, first
    copy the program, then check the operation at the line, flip it if it is
    NOP or JMP. Then execute the program, and make sure it does not get caught
    in an infinite loop. We were told the program would only execute each
    instruction once, so the first repeat is considered an infinite loop.
    Return the accumulator value of the successfully run program.
    '''
    program = get_input()

    for line_number in range(len(program)):
        program_copy = program.copy()

        (op, value, _) = parse_instruction(program_copy[line_number])

        if op == 'acc':
            continue

        # Flip operation and write new instruction
        op = 'jmp' if op == 'nop' else 'nop'
        program_copy[line_number] = op + ' ' + str(value)

        accumulator = execute_program(program_copy)
        if accumulator > 0:
            return accumulator

    return -1


print(debug_program())
