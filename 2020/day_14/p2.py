from tools import get_input
import re


def apply_float(num):
    '''
    Recursive function that will translate X into 1 and 0 for each
    position that it is in.
    '''
    addresses = []

    try:
        idx = num.index('X')
    except ValueError:
        return [int(''.join(num), 2)]

    zero_route = num.copy()
    zero_route[idx] = '0'
    addresses = addresses + apply_float(zero_route)
    one_route = num.copy()
    one_route[idx] = '1'
    addresses = addresses + apply_float(one_route)

    return addresses


def apply_mask(number, mask):
    '''
    Turn the number into binary, except in part 2 here, 0 in the mask was
    the bitwise OR. Xs were written in as floating values, such that they
    could take on 1 or 0.
    '''
    num = str(bin(number)).replace("0b", "")
    itr = len(num)
    for itr in range(36 - itr):
        num = '0' + num

    num = list(num)
    mask = list(mask)
    itr = 0
    for itr in range(36):
        if mask[itr] == '0':
            continue

        num[itr] = mask[itr]

    return apply_float(num)


def sum_masked_addresses():
    '''
    Reading the input, it assigns a value to a memory address, except that
    the mask has a floating representation, and so the value gets assigned
    to multiple memory addresses. After the mask has been applied, sum the
    values in the memory addresses.
    '''
    values = get_input()

    memory = {}

    for val in values:
        if 'mask = ' in val:
            mask = val[7:]
        else:
            match = re.search(r'mem\[(\d+)\] = (\d+)', val)
            addresses = apply_mask(int(match.group(1)), mask)
            for address in addresses:
                memory[address] = int(match.group(2))

    return sum(list(memory.values()))


results = sum_masked_addresses()

print('Puzzle Answer: ', results)
