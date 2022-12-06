from os.path import dirname, realpath, join
import re


def get_input() -> list:
    dir_path = dirname(realpath(__file__))
    with open(join(dir_path, "input.txt"), "r") as infile:
        report = infile.read().splitlines()
    return report


def parse_string(item: str) -> tuple:
    '''
    Breaks down each line of the input file and returns
    a tuple of the expected groups.

    Example String: "2-5 w: liksdjfgasdww"

    Groups are; the first number, second number, letter, and password.
    '''
    return re.match(r'^(\d+)-(\d+) ([a-z]): ([a-z]+)$', item).groups()
