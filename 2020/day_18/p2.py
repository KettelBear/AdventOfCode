from math import prod
from tools import get_input


def resolve_parens(eqtn):
    '''
    This was fun to write. Because there are both inner
    parens, but could also be multiple groups within.
    So this recursive function solves the parens from
    right to left, then outer beyond that.
    '''
    opening = eqtn.find('(')

    if opening == -1:
        closing = eqtn.find(')')

        if closing == -1:
            return str(calculate(eqtn))

        return str(calculate(eqtn[:closing])) + eqtn[closing+1:]

    return resolve_parens(eqtn[0:opening] + resolve_parens(eqtn[opening+1:]))


def calculate(eqtn):
    pieces = eqtn.split(' ')

    if '+' in pieces:
        idx = pieces.index('+')

        # Calculate the sum first
        new_val = int(pieces[idx-1]) + int(pieces[idx+1])

        # Put the sum back in the equation
        pieces[idx] = str(new_val)

        # Remove the first number that was summed
        del pieces[idx-1]

        # Since the list indices change, this is removing
        # the other number from the sum.
        del pieces[idx]

        # Continue calculating the new equation resolving
        # sums first.
        return calculate(' '.join(pieces))

    # After all sums are calculated, find the product.
    product = 1
    for piece in pieces:
        if piece.isdigit():
            product *= int(piece)

    return product


def day_18():
    equations = get_input().splitlines()

    sum_ = 0
    for equation in equations:
        equation = resolve_parens(equation)
        sum_ += int(calculate(equation))

    return sum_


results = day_18()

print('Puzzle Answer:', results)
