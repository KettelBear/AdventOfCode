from tools import get_input


def get_product(report: list) -> int:
    '''
    Not quite as eloquent as the sum of 2 numbers. Instead this will iterate
    (without covering any combination of 3 values more than once) over each
    combination, checking the sums. If the first two values found add up to
    or more than 2020, it will skip the loop for the 3rd value, and move the
    2nd iterator up one position. Once the 3 values add to exactly 2020, it
    will return the product of those 3 values.
    '''
    length = len(report)
    i = 0
    while i < length - 2:
        j = 1 + i
        while j < length - 1:
            first = int(report[i])
            second = int(report[j])
            if first + second >= 2020:
                j += 1
                continue
            k = 1 + j
            while k < length:
                third = int(report[k])
                sum_ = first + second + third
                if sum_ == 2020:
                    return first * second * third
                k += 1
            j += 1
        i += 1


print(get_product(get_input()))
