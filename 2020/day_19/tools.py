from os.path import dirname, realpath, join


def get_input() -> str:
    dir_path = dirname(realpath(__file__))
    with open(join(dir_path, "input.test"), "r") as infile:
        report = infile.read()
    return report
