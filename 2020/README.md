# Advent Of Code 2020

My solutions to the Advent of Code challenge for 2020. After this abysmal year,
it is nice to look forward to a bit of fun. Thank you to those that have found a
way to contribute and/or sponsor this event.

I chose to do the advent of code in `python`. It was somewhat an arbitrary
choice. In my current position, I get practice `PHP`, `JavaScript`, and
`Java`. For a personal project, I am currently writing a Twitch chat bot in
`TypeScript` (You can read more about that
[here](https://github.com/sbreining/theoretically-meh)). That hopefully explains
the decision to opt for `python`.

## Project Structure

Each day will have a folder with the name `day_[\d]{2}`. Within each folder will
be `p1.py` and `p2.py` (for each part of the day), `input.txt` for the challenge
input, and `tools.py` which is collection of helper functions that do not directly
impact the solution. I will use the `os` module so that the code can be run from
any directory. Like `python day_1/p1.py` or `cd day_1` then `python p1.py`.
