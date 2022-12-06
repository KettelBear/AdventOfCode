from os.path import dirname, realpath, join


def get_input() -> list:
    dir_path = dirname(realpath(__file__))
    with open(join(dir_path, "input.txt"), "r") as infile:
        report = infile.read().splitlines()
    return [list(word) for word in report]
