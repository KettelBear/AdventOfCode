from os.path import dirname, realpath, join


def get_file_contents() -> list:
    dir_path = dirname(realpath(__file__))
    with open(join(dir_path, "input.txt"), "r") as infile:
        report = infile.readlines()
    return report


def get_input():
    input_ = get_file_contents()
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
