from tools import get_input


def get_product(report: list) -> int:
    '''
    This does a single pass through the array of numbers, storing the previously
    seen values in a dictionary. Take the given number, and find its compliment
    (2020 minus number). If the dictionary contains that number, we've already
    seen it, and we know we can add the current number and compliment to get
    2020. Just return the product at that point.
    '''
    dictionary = {}

    for i in range(len(report)):
        num = int(report[i])
        compliment = 2020 - num

        if dictionary.get(compliment) is not None:
            return compliment * num

        dictionary[num] = i


print(get_product(get_input()))
