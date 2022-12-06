from p1 import find_invalid_number
from tools import get_input


def get_min_max(subset: list) -> tuple:
    '''
    Simple function to get the minimum and maximum values in the provided
    list.
    '''
    low = subset[0]
    high = subset[0]
    for item in subset:
        if item < low:
            low = item
        if item > high:
            high = item

    return low, high


def find_contiguous_subset():
    '''
    Given our input for part 1, we found an number that didn't fit the
    given criteria. We are then told that there exists a contiguous set
    of numbers in the input that will add to the invalid number. However,
    we were not told the subset size that will sum to the number. Starting
    with a set of 2, we'll loop though the input to find a subset of
    consecutive numbers that sum to the invalid number, incrementing the
    size of the subset with each loop.
    '''
    values = get_input()
    invalid = find_invalid_number(values)

    subset_length = 2
    while subset_length <= len(values):
        itr = 0

        while itr + subset_length <= len(values):
            contiguous_subset = values[itr:itr+subset_length]

            if sum(contiguous_subset) == invalid:
                low, high = get_min_max(contiguous_subset)
                return low + high

            itr += 1

        subset_length += 1


if __name__ == '__main__':
    print(find_contiguous_subset())
