package two.thousand.fifteen.day08;

import two.thousand.fifteen.Utility;

import java.util.Arrays;
import java.util.List;

public class Day08 {
    public static String partOne() {
        List<String> input = Utility.getMultilineInput("src/two/thousand/fifteen/day08/input.prod");

        int diff = 0;
        for (String in : input) diff += lineDifference(in);

        return String.valueOf(diff);
    }

    public static String partTwo() {
        List<String> input = Utility.getMultilineInput("src/two/thousand/fifteen/day08/input.prod");

        int diff = 0;
        for (String in : input) diff += encodedDifference(in);

        return String.valueOf(diff);
    }

    private static int lineDifference(String line) {
        return line.length() - stringValue(line).length();
    }

    private static String stringValue(String stringLiteral) {
        char[] chars = stringLiteral.toCharArray();
        StringBuilder stringCharacters = new StringBuilder();
        for (int idx = 1; idx < chars.length - 1; idx++) {
            if (chars[idx] == '\\') {
                switch (chars[idx + 1]) {
                    case '"' -> {
                        stringCharacters.append('"');
                        idx++;
                    }
                    case '\\' -> {
                        stringCharacters.append('\\');
                        idx++;
                    }
                    case 'x' -> {
                        char[] hex = Arrays.copyOfRange(chars, idx + 2, idx + 4);
                        stringCharacters.append(translateHex(new String(hex)));
                        idx += 3;
                    }
                }
            } else {
                stringCharacters.append(chars[idx]);
            }
        }

        return stringCharacters.toString();
    }

    private static String translateHex(String hex) {
        return new String((char) Integer.parseInt(new String(hex), 16) + "");
    }

    private static int encodedDifference(String line) {
        return encode(line).length() - line.length();
    }

    private static String encode(String literal) {
        StringBuilder encoded = new StringBuilder();

        encoded.append('\"');
        char[] chars = literal.toCharArray();
        for (char c : chars) {
            switch (c) {
                case '"', '\\' -> encoded.append('\\').append(c);
                default -> encoded.append(c);
            }
        }
        encoded.append('\"');

        return encoded.toString();
    }
}
