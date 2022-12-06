from tools import get_input, parse_string


def num_of_valid_passwords(pass_list: list) -> int:
    '''
    In this version of the password validation, it requires an XOR of sorts.
    Instead of the two numbers in the input representing a range for the
    required character, they represent two positions in the password string.
    Keep in mind those positions are not 0-index based. Instead, the required
    character is expected to be at one of the two positions, but not both. If
    that is true, we'll increment valid_passwords.
    '''
    valid_passwords = 0
    for item in pass_list:
        (pos_1, pos_2, req_char, password) = parse_string(item)

        char_one = password[int(pos_1) - 1]
        char_two = password[int(pos_2) - 1]

        if char_one != char_two and (char_one == req_char or char_two == req_char):
            valid_passwords += 1

    return valid_passwords


print(num_of_valid_passwords(get_input()))
