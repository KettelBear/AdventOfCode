from tools import get_input


point_map = dict({')': 1, ']': 2, '}': 3, '>': 4})
closer_lookup = dict({'(': ')', '[': ']', '{': '}', '<': '>'})


def get_completions(nav_reading):
    completions = list()
    for line in nav_reading:
        is_bad = False
        closing_stack = list()

        for char in line:
            if char in ['(', '[', '{', '<']:
                closing_stack.append(closer_lookup[char])
            elif char == closing_stack[-1]:
                closing_stack.pop()
            else:
                is_bad = True
                break

        if not is_bad:
            completions.append(closing_stack)

    return completions


def get_sorted_completion_scores(completions):
    completion_scores = list()

    for completion in completions:
        score = 0

        # Pop each completion character off the stack.
        while completion:
            score = score * 5 + point_map[completion.pop()]

        completion_scores.append(score)

    completion_scores.sort()

    return completion_scores


def solution():
    nav_reading = get_input('input.prod')
    completions = get_completions(nav_reading)
    completion_scores = get_sorted_completion_scores(completions)

    return completion_scores[int(len(completion_scores) / 2)]


print(solution())
