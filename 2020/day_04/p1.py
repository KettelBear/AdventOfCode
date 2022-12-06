from tools import get_input
import re


def get_passports():
    input_ = get_input()
    passports = []

    tempstring = ""
    for passport in input_:
        if passport != '':
            tempstring += passport
        else:
            passports.append(tempstring)
            tempstring = ""

    # Add remaining passport if any.
    if tempstring:
        passports.append(tempstring)

    return passports


def day_4():
    passports = get_passports()

    good_passports = 0
    for passport in passports:
        required_fields = ['byr', 'iyr', 'eyr', 'hgt', 'hcl', 'ecl', 'pid']
        col_pos = passport.find(':')
        while col_pos > 0:
            pp_data = passport[col_pos-3:col_pos]
            try:
                required_fields.remove(pp_data)
            except ValueError:
                pass
            passport = passport[col_pos+1:]
            col_pos = passport.find(':')
        if required_fields == []:
            good_passports += 1

    return good_passports


print(day_4())
