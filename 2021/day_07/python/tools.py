from os.path import dirname, realpath, join


def get_input(file_name: str) -> list:
    dir_path = dirname(realpath(__file__))
    with open(join(dir_path, file_name), "r") as infile:
        report = [int(x) for x in infile.read().split(',')]
    return report
