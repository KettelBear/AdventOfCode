from string import ascii_lowercase as questions
from tools import get_input


def anyone_answered_yes():
    '''
    We received a collection of questionnaires, where the groups of people
    are separated by a blank line, and an individual's answer is separated
    by a newline. We iterate through, and find all questions that were
    answered 'yes' (exist in the questionnaire for the individual) for the
    whole group. Then, return the sum of questions answered by each group.
    '''
    questionnaires = get_input()

    count = 0
    for questionnaire in questionnaires:
        for question in questions:
            if question in questionnaire:
                count += 1

    return count


print(anyone_answered_yes())
