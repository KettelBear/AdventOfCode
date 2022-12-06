package two.thousand.fifteen.day02;

import two.thousand.fifteen.Utility;

import java.util.Arrays;
import java.util.List;

public class Day02 {
    public static String partOne() {
        List<String> input = Utility.getMultilineInput("src/two/thousand/fifteen/day02/input.prod");

        int sqft = 0;
        for (String dimensions : input) {
            int[] dims = convertToInt(dimensions.split("x"));
            sqft += calculateWrappingPaper(dims);
        }

        return Integer.toString(sqft);
    }

    public static String partTwo() {
        List<String> input = Utility.getMultilineInput("src/two/thousand/fifteen/day02/input.prod");

        int feet = 0;
        for (String dimensions : input) {
            int[] dims = convertToInt(dimensions.split("x"));
            feet += calculateRibbon(dims);
        }

        return Integer.toString(feet);
    }

    private static int calculateWrappingPaper(int[] dimensions) {
        int side1 = dimensions[0] * dimensions[1],
                side2 = dimensions[1] * dimensions[2],
                side3 = dimensions[0] * dimensions[2];

        int smallest = Math.min(side1, Math.min(side2, side3));

        return 2 * side1 + 2 * side2 + 2 * side3 + smallest;
    }

    private static int calculateRibbon(int[] dimensions) {
        int volume = dimensions[0] * dimensions[1] * dimensions[2];

        Arrays.sort(dimensions);

        return dimensions[0] * 2 + dimensions[1] * 2 + volume;
    }

    private static int[] convertToInt(String[] dimensions) {
        int[] dims = new int[3];

        for (int i = 0; i < dimensions.length; i++) {
            dims[i] = Integer.parseInt(dimensions[i]);
        }

        return dims;
    }
}
