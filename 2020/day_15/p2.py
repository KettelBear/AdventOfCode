from time import time


def get_30_millionth_number():
    '''
    The goal is to find the 30 millionth number in the sequence.
    The dictionary will key by the number in the sequence, and the
    value will be a list of the indices where the key was seen in
    the sequence. The next number in the sequence is the difference
    in the two most recent positions of the previous number in the
    sequence, or 0 if the number has not been seen before. This
    solution, an iteration on part 1, is much better for time, but
    not _as_ good with space.
    If I took more time, I could figure out how to have each key
    only hold at most 2 values, which would be much better for
    space.
    '''
    # {number_in_sequence: [positions_seen]}
    dictionary = {9: [1], 3: [2], 1: [3], 0: [4], 8: [5], 4: [6]}

    next_ = 4
    for itr in range(7, 30000001):
        # If the index list is length 1, then the number has not been
        # seen except for just now, so we'll add an index to 0 in the
        # else block.
        if len(dictionary.get(next_)) > 1:
            positions = dictionary.get(next_)
            # The difference in the 2 most recent indices of the number.
            next_ = positions[-1] - positions[-2]
            if dictionary.get(next_) is not None:
                dictionary[next_].append(itr)
            else:
                dictionary[next_] = [itr]
        else:
            if dictionary.get(0) is not None:
                dictionary[0].append(itr)
            else:
                dictionary[0] = [itr]
            next_ = 0

    return next_


start = time()
results = get_30_millionth_number()
end = time()

print('Puzzle Answer:', results)
print('Answer found in: {}s'.format(round(end - start, 3)))
