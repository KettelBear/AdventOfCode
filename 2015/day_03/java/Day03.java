package two.thousand.fifteen.day03;

import two.thousand.fifteen.Utility;

import java.util.HashMap;
import java.util.Map;

public class Day03 {
    public static String partOne() {
        String input = Utility.getSingleLineInput("src/two/thousand/fifteen/day03/input.prod");

        Map<String, Integer> presentMap = new HashMap<>();

        int vertical = 0, lateral = 0;
        for (char direction : input.toCharArray()) {
            String location = vertical + "," + lateral;
            presentMap.merge(location, 1, Integer::sum);
            switch (direction) {
                case '^' -> vertical++;
                case '>' -> lateral++;
                case 'v' -> vertical--;
                case '<' -> lateral--;
            }
        }

        return Integer.toString(presentMap.size());
    }

    public static String partTwo() {
        String input = Utility.getSingleLineInput("src/two/thousand/fifteen/day03/input.prod");

        Map<String, Integer> presentMap = new HashMap<>();

        boolean isSanta = true;
        int santaX = 0, santaY = 0, robotX = 0, robotY = 0, throwAway = 0;
        for (char direction : input.toCharArray()) {
            String location = isSanta ? santaX + "," + santaY : robotX + "," + robotY;
            presentMap.merge(location, 1, Integer::sum);
            switch (direction) {
                case '^' -> { throwAway = isSanta ? santaX++ : robotX++; }
                case '>' -> { throwAway = isSanta ? santaY++ : robotY++; }
                case 'v' -> { throwAway = isSanta ? santaX-- : robotX--; }
                case '<' -> { throwAway = isSanta ? santaY-- : robotY--; }
            }
            isSanta = !isSanta;
        }

        return Integer.toString(presentMap.size());
    }
}
