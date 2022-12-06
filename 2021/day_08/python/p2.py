from tools import get_input


def get_digit(digits, signal):
    inverse_digits = {value: str(key) for key, value in digits.items()}

    return inverse_digits[signal]


def get_output(digits, output):
    return int(''.join([get_digit(digits, code) for code in output]))


def same(first, second):
    first = set(first)
    second = set(second)

    return len(first & second)


def diff(first, second):
    first = set(first)
    second = set(second)

    return len((first | second) - (first & second))


def decode_wires(codes):
    digits = {}
    for code in codes:
        if len(code) == 2:
            digits[1] = code
        elif len(code) == 3:
            digits[7] = code
        elif len(code) == 4:
            digits[4] = code
        elif len(code) == 7:
            digits[8] = code

    for code in codes:
        if len(code) == 5:
            if diff(digits[1], code) == 3:
                digits[3] = code
            elif diff(digits[4], code) == 3:
                digits[5] = code
            else:
                digits[2] = code
        elif len(code) == 6:
            if same(digits[1], code) == 1:
                digits[6] = code
            elif same(digits[4], code) == 4:
                digits[9] = code
            else:
                digits[0] = code

    return digits


def solution():
    signals = get_input("input.prod")

    sum_ = 0
    for signal in signals:
        codes, output = signal.split(" | ")
        codes = list(map(''.join, map(sorted, codes.split())))
        output = list(map(''.join, map(sorted, output.split())))

        digits = decode_wires(codes)

        sum_ += get_output(digits, output)

    return sum_


print(solution())
