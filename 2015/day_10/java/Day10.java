package two.thousand.fifteen.day10;


public class Day10 {
    private static final int P1_GENERATIONS = 40;
    private static final int P2_GENERATIONS = 50;

    private static final String PUZZLE_INPUT = "1113222113";

    public static String partOne() {
        String result = PUZZLE_INPUT;

        for (int i = 0; i < P1_GENERATIONS; i++) result = lookAndSay(result);

        return String.valueOf(result.length());
    }

    public static String partTwo() {
        String result = PUZZLE_INPUT;

        for (int i = 0; i < P2_GENERATIONS; i++) result = lookAndSay(result);

        return String.valueOf(result.length());
    }

    private static String lookAndSay(String input) {
        char[] numbers = input.toCharArray();

        StringBuilder result = new StringBuilder();

        char curr = numbers[0];
        int counter = 0;
        for (char number : numbers) {
            if (curr == number) {
                counter++;
            } else {
                result.append(counter).append(curr);
                // The current character counts as one seen.
                // So counter starts at 1 instead of 0.
                counter = 1;
                curr = number;
            }
        }

        // Empty the buffer.
        result.append(counter).append(curr);

        return result.toString();
    }
}
