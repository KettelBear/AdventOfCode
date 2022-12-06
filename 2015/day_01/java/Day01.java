package two.thousand.fifteen.day01;

import two.thousand.fifteen.Utility;

public class Day01 {
    public static String partOne() {
        String input = Utility.getSingleLineInput("src/two/thousand/fifteen/day01/input.prod");

        int floor = 0;
        for (char paren : input.toCharArray()) floor += paren == '(' ? 1 : -1;

        return Integer.toString(floor);
    }

    public static String partTwo() {
        String input = Utility.getSingleLineInput("src/two/thousand/fifteen/day01/input.prod");

        int position = 0, floor = 0;
        for (char paren : input.toCharArray()) {
            floor += paren == '(' ? 1 : -1;
            position += 1;

            if (floor == -1) break;
        }

        return Integer.toString(position);
    }
}
