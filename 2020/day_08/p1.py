from tools import get_input, parse_instruction


def exectue_program() -> int:
    '''
    This will execute the given program (puzzle input), and keep track of
    the accumulator value. Then it will return the accumulator value at the
    first repeated instruction.
    '''
    program = get_input()

    accumulator = line_number = 0
    while line_number < len(program):
        (op, value, was_executed) = parse_instruction(program[line_number])

        if was_executed:
            break

        program[line_number] += ' executed'

        if op == 'acc':
            accumulator += value
            line_number += 1
        elif op == 'jmp':
            line_number += value
        else:
            line_number += 1

    return accumulator


print(exectue_program())
