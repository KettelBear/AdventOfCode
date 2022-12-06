package two.thousand.fifteen.day12;

import two.thousand.fifteen.Utility;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class Day12 {
    public static String partOne() {
        String input = Utility.getSingleLineInput("src/two/thousand/fifteen/day12/input.prod");
        String[] numbers = input.split("[a-z\"'{},:\\[\\]]");

        int sum = 0;
        for (String num : numbers) if (!num.isEmpty()) sum += Integer.parseInt(num);

        return String.valueOf(sum);
    }

    public static String partTwo() {
        String input = Utility.getSingleLineInput("src/two/thousand/fifteen/day12/input.prod");

        Pattern p = Pattern.compile("\\{[^{]+?}");
        for (Matcher m = p.matcher(input); m.find(); m = p.matcher(input)) {
            input = input.replaceFirst("" + p, "" + getSum(m.group()));
        }

        return String.valueOf(getSum(input));
    }

    public static int getSum(String s) {
        int value = 0;
        for (Matcher m = Pattern.compile("-?\\d+").matcher(s); m.find() && !s.contains(":\"r"); ) {
            value += Integer.parseInt(m.group());
        }
        return value;
    }
}
