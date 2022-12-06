from tools import get_input, parse_string


def num_of_valid_passwords(pass_list: list) -> int:
    '''
    Password validation requires a range of the required character. The
    parse_string call will return the min and max, as well as the required
    character and password itself. If it is in range, increment valid_passwords.
    '''
    valid_passwords = 0
    for item in pass_list:
        (min_, max_, req_char, password) = parse_string(item)

        if int(min_) <= password.count(req_char) <= int(max_):
            valid_passwords += 1

    return valid_passwords


print(num_of_valid_passwords(get_input()))
