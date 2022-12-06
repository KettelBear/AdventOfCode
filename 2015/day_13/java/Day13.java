package two.thousand.fifteen.day13;

import two.thousand.fifteen.Utility;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class Day13 {
    private static Map<String, Map<String, Integer>> neighbors;
    private static List<List<String>> possibleArrangements;

    public static String partOne() {
        setUp("src/two/thousand/fifteen/day13/input.prod");

        int arrangedSeating = findHappiestSeatingArrangement();

        return String.valueOf(arrangedSeating);
    }

    public static String partTwo() {
        setUp("src/two/thousand/fifteen/day13/input2.prod");

        int arrangedSeating = findHappiestSeatingArrangement();

        return String.valueOf(arrangedSeating);
    }

    private static int findHappiestSeatingArrangement() {
        int happiest = 0;

        for (List<String> arrangement : possibleArrangements) {
            int happiness = 0;

            for (int seat = 0; seat < arrangement.size(); seat++) {
                String person = arrangement.get(seat);
                int n1 = neighbors.get(person).get(arrangement.get((seat == 0 ? arrangement.size() - 1 : seat - 1)));
                int n2 = neighbors.get(person).get(arrangement.get((seat == arrangement.size() - 1 ? 0 : seat + 1)));
                happiness += n1 + n2;
            }

            if (happiness > happiest) happiest = happiness;
        }

        return happiest;
    }

    private static int getNeighborCalculation(int seat, String person) {

        return 0;
    }

    private static void setUp(String inFile) {
        List<String> input = Utility.getMultilineInput(inFile);

        neighbors = new HashMap<>();

        for (String in : input) {
            String[] wordyInput = in.split(" ");
            String person = wordyInput[0];
            int happiness = Integer.parseInt(wordyInput[3]) * (wordyInput[2].equals("gain") ? 1 : -1);
            String neigh = wordyInput[wordyInput.length - 1];
            String neighbor = neigh.substring(0, neigh.length() - 1);

            Map<String, Integer> meter = neighbors.get(person);
            if (meter != null) meter.put(neighbor, happiness);
            else {
                meter = new HashMap<>();
                meter.put(neighbor, happiness);
            }

            neighbors.put(person, meter);

            possibleArrangements = Utility.permute(neighbors.keySet());
        }
    }
}
