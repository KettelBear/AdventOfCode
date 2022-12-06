from tools import get_input

preamble = 25


def find_invalid_number(values):
    '''
    We are informed that any given number has a pair that sums to it
    in a given subset behind it in the list. So we are lookin for a
    value that breaks this rule, and return that value.
    '''
    itr = preamble
    while itr < len(values):
        i = itr - preamble
        val_to_check = values[itr]
        has_pair = False

        while i < itr:
            compliment = val_to_check - values[i]
            if compliment in values[i:itr]:
                has_pair = True
                break
            i += 1

        if not has_pair:
            return val_to_check

        itr += 1

    return -1


if __name__ == '__main__':
    values = get_input()
    print(find_invalid_number(values))
