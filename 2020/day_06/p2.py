from string import ascii_lowercase as questions
from tools import get_input


def everyone_answered_yes():
    '''
    Very similar to part 1, except here, we want to find all the
    questions where everyone in a group answered 'yes' (the question
    is present), instead of just anyone answered yes. Then we sum
    the questions for which the entire group said yes with the
    other groups.
    '''
    questionnaires = get_input()

    count = 0
    for questionnaire in questionnaires:
        for question in questions:
            individual_questionnaires = questionnaire.split(' ')
            all_answered = True
            for individual_questionnaire in individual_questionnaires:
                if question not in individual_questionnaire:
                    all_answered = False
                    break
            if all_answered:
                count += 1

    return count


print(everyone_answered_yes())
