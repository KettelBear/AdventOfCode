from tools import get_input


def resolve_parens(eqtn):
    opening = eqtn.find('(')

    if opening == -1:
        closing = eqtn.find(')')
        if closing == -1:
            return str(calculate(eqtn))
        sub_eq = eqtn[:closing]
        val = calculate(sub_eq)
        new_eq = str(val) + eqtn[closing+1:]
        return new_eq

    other_eq = eqtn[0:opening] + resolve_parens(eqtn[opening+1:])

    return resolve_parens(other_eq)


def calculate(eqtn):
    pieces = eqtn.split(' ')

    i = 0
    while i < len(pieces) - 1:
        if pieces[i+1] == '*':     
            pieces[i+2] = int(pieces[i]) * int(pieces[i+2])
        else:
            pieces[i+2] = int(pieces[i]) +  int(pieces[i+2])
        i += 2

    return pieces.pop()


def day_18():
    equations = get_input().splitlines()

    sum_ = 0
    for equation in equations:
        equation = resolve_parens(equation)
        sum_ += int(calculate(equation))

    return sum_

results = day_18()

print('Puzzle Answer:', results)

