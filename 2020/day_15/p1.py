def get_2020th_number():
    '''
    In such a small set (only 2000 numbers), this solution double
    loops. It looks at the current number, then looks backwards
    through the subset that is all _but_ the current number. This
    is not efficient for time, but it is for space. This solution
    was also "good" for a first iteration.
    '''
    values = [9, 3, 1, 0, 8, 4]

    for itr in range(7, 2021):
        curr = values[-1]

        found = False
        for i in range(len(values) - 2, -1, -1):
            if values[i] == curr:
                values.append(itr - i - 2)
                found = True
                break

        if not found:
            values.append(0)

    return values.pop()


results = get_2020th_number()

print('Puzzle Answer: ', results)
