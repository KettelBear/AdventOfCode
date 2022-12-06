package two.thousand.fifteen.day05;

import two.thousand.fifteen.Utility;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class Day05 {
    public static String partOne() {
        List<String> inputs = Utility.getMultilineInput("src/two/thousand/fifteen/day05/input.prod");

        int niceWords = 0;
        for (String input : inputs) {
            if (hasVowels(input) && hasDouble(input) && !hasBadActor(input)) niceWords++;
        }

        return Integer.toString(niceWords);
    }

    public static String partTwo() {
        List<String> inputs = Utility.getMultilineInput("src/two/thousand/fifteen/day05/input.prod");

        int niceWords = 0;
        for (String input : inputs) {
            if (hasTwoPair(input) && hasOneBetween(input)) niceWords++;
        }

        return Integer.toString(niceWords);
    }

    private static boolean hasVowels(String word) {
        List<Character> vowels = new ArrayList<>(Arrays.asList('a', 'e', 'i', 'o', 'u'));

        int vowelCount = 0;
        for (char c : word.toCharArray()) {
            if (vowels.contains(c)) vowelCount++;
            if (vowelCount > 2) return true;
        }

        return false;
    }

    private static boolean hasDouble(String word) {
        for (int i = 0; i < word.length() - 1; i++) {
            if (word.charAt(i) == word.charAt(i + 1)) {
                return true;
            }
        }

        return false;
    }

    private static boolean hasBadActor(String word) {
        String[] badActors = {"ab", "cd", "pq", "xy"};

        for (String badActor : badActors) {
            if (word.contains(badActor)) {
                return true;
            }
        }

        return false;
    }

    private static boolean hasTwoPair(String word) {
        for (int i = 0; i < word.length() - 3; i++) {
            String pair = word.charAt(i) + "" + word.charAt(i + 1) + "";
            for (int j = i + 2; j < word.length() - 1; j++) {
                String other = word.charAt(j) + "" + word.charAt(j + 1) + "";
                if (pair.equals(other)) {
                    return true;
                }
            }
        }

        return false;
    }

    private static boolean hasOneBetween(String word) {
        for (int i = 0; i < word.length() - 2; i++) {
            char c = word.charAt(i);
            if (c == word.charAt(i + 2) && c != word.charAt(i + 1)) {
                return true;
            }
        }
        return false;
    }
}
