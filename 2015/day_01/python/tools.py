from os.path import dirname, realpath, join


def get_input(in_file: str) -> list:
    dir_path = dirname(realpath(__file__))
    with open(join(dir_path, in_file), "r") as infile:
        report = infile.read()
    return report
