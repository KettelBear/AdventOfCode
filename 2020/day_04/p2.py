from os.path import dirname, realpath, join
import re


def get_input() -> list:
    dir_path = dirname(realpath(__file__))
    with open(join(dir_path, "input.txt"), "r") as infile:
        report = infile.readlines()
    return report


def get_passports():
    input_ = get_input()
    passports = []

    tempstring = ""
    for line in input_:
        if line != '\n':
            tempstring += (" " + line.strip())
        else:
            passports.append(tempstring.strip())
            tempstring = ""

    # Add remaining passport if any.
    if tempstring:
        passports.append(tempstring.strip())

    return passports


def is_valid_byr(byr: str) -> bool:
    try:
        byr = int(byr)
    except:
        return False

    return 1920 <= byr <= 2002


def is_valid_iyr(iyr: str) -> bool:
    try:
        iyr = int(iyr)
    except:
        return False

    return 2010 <= iyr <= 2020


def is_valid_eyr(eyr: str) -> bool:
    try:
        eyr = int(eyr)
    except:
        return False

    return 2020 <= eyr <= 2030


def is_valid_hgt(hgt: str) -> bool:
    pos = hgt.find('cm')
    is_cm = True
    if pos < 0:
        is_cm = False
        pos = hgt.find('in')

    if pos < 0:
        return False

    str_val = hgt[:pos]
    val = 0
    try:
        val = int(str_val)
    except:
        return False

    if is_cm:
        return 150 <= val <= 193
    else:
        return 59 <= val <= 76


def day_4():
    passports = get_passports()

    good_passports = 0
    for passport in passports:
        byr = re.match(r'.*byr:(\d{4})', passport)
        if byr == None:
            continue
        byr = byr.group(1)
        if not is_valid_byr(byr):
            continue

        iyr = re.match(r'.*iyr:(\d{4})', passport)
        if iyr == None:
            continue
        iyr = iyr.group(1)
        if not is_valid_iyr(iyr):
            continue

        eyr = re.match(r'.*eyr:(\d{4})', passport)
        if eyr == None:
            continue
        eyr = eyr.group(1)
        if not is_valid_eyr(eyr):
            continue

        hgt = re.match(r'.*hgt:(\d{2,3}(in|cm))', passport)
        if hgt == None:
            continue
        hgt = hgt.group(1)
        if not is_valid_hgt(hgt):
            continue

        hcl = re.match(r'.*hcl:#[a-f0-9]{6}', passport)
        if hcl == None:
            continue

        ecl = re.match(
            r'.*ecl:(amb|blu|brn|gry|grn|hzl|oth)', passport)
        if ecl == None:
            continue

        pid = re.match(r'.*pid:(\d{9})', passport)
        if pid == None:
            continue

        good_passports += 1

    return good_passports


print(day_4())
