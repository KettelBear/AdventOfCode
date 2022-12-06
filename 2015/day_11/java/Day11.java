package two.thousand.fifteen.day11;


public class Day11 {
    private static final String PUZZLE_INPUT = "hepxcrrq";
    private static final String PART_TWO_INPUT = "hepxxyzz";

    public static String partOne() {
        String password = PUZZLE_INPUT;

        while (!isPasswordValid(password)) password = incrementPassword(password);

        return password;
    }

    public static String partTwo() {
        String password = PART_TWO_INPUT;

        // Need to increment once because it satisfies the conditions and doesn't loop.
        password = incrementPassword(password);

        while (!isPasswordValid(password)) password = incrementPassword(password);

        return password;
    }

    private static String incrementPassword(String current) {
        char[] characters = current.toCharArray();
        int lastIndex = characters.length - 1;

        characters[lastIndex]++;

        for (int i = lastIndex; i > 0; i--) {
            if (characters[i] > 'z') {
                characters[i] = 'a';
                characters[i-1]++;
            }
        }

        if (characters[0] > 'z') characters[0] = 'a';

        return new String(characters);
    }

    private static boolean isPasswordValid(String password) {
        return hasConsecutiveLetters(password) && !hasBadChars(password) && hasTwoPair(password);
    }

    private static boolean hasConsecutiveLetters(String password) {
        char[] characters = password.toCharArray();

        for (int i = 0; i < characters.length - 3; i++) {
            if (characters[i + 2] - characters[i + 1] == 1 && characters[i + 1] - characters[i] == 1) return true;
        }

        return false;
    }

    private static boolean hasBadChars(String password) {
        char[] characters = password.toCharArray();

        for (char c : characters) {
            if (c == 'i' || c == 'l' || c == 'o') return true;
        }

        return false;
    }

    private static boolean hasTwoPair(String password) {
        char[] characters = password.toCharArray();

        for (int i = 0; i < characters.length - 4; i++) {
            if (characters[i] == characters[i+1]) {
                for (int j = i + 2; j < characters.length - 1; j++) {
                    if (characters[j] != characters[i] && characters[j] == characters[j + 1]) return true;
                }
            }
        }

        return false;
    }
}
