from tools import get_input
import re


def apply_mask(number, mask):
    '''
    Turn the number into binary, remove the '0b' at the beginning
    then pad it to a 36 bits. Now the mask can be applied, then
    converted back to decimal. In part 1 here, X in the mask meant
    keep the bit whatever value it is, otherwise the mask overwrites
    the bit it is holding into the position.
    '''
    num = str(bin(number)).replace("0b", "")
    itr = len(num)
    for itr in range(36 - itr):
        num = '0' + num

    num = list(num)
    mask = list(mask)
    itr = 0
    for itr in range(36):
        if mask[itr] == 'X':
            continue

        num[itr] = mask[itr]

    return int("".join(num), 2)


def sum_masked_values():
    '''
    Read the instructions to assign values to memory addresses, after
    the mask had been applied to those values. Then sum the values in
    the addresses.
    '''
    values = get_input()

    memory = {}

    for val in values:
        if 'mask = ' in val:
            mask = val[7:]
        else:
            match = re.search(r'mem\[(\d+)\] = (\d+)', val)
            memory[int(match.group(1))] = apply_mask(int(match.group(2)), mask)

    return sum(list(memory.values()))


results = sum_masked_values()

print('Puzzle Answer: ', results)
