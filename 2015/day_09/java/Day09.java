package two.thousand.fifteen.day09;

import two.thousand.fifteen.Utility;

import java.util.*;

public class Day09 {
    private static Map<String, Integer> distances;
    private static List<List<String>> allRoutes;
    private static boolean isSetUp = false;

    public static String partOne() {
        setUp();

        return String.valueOf(findShortestRoute(allRoutes, distances));
    }

    public static String partTwo() {
        setUp();

        return String.valueOf(findLongestRoute(allRoutes, distances));
    }

    private static int findLongestRoute(List<List<String>> allRoutes, Map<String, Integer> distances) {
        int longest = Integer.MIN_VALUE;

        for (List<String> route : allRoutes) {
            int sum = 0;
            for (int i = 0; i < route.size() - 1; i++) {
                sum += distances.get(route.get(i) + " to " + route.get(i + 1));
            }

            if (sum > longest) longest = sum;
        }

        return longest;
    }

    private static int findShortestRoute(List<List<String>> allRoutes, Map<String, Integer> distances) {
        int shortest = Integer.MAX_VALUE;

        for (List<String> route : allRoutes) {
            int sum = 0;
            for (int i = 0; i < route.size() - 1; i++) {
                sum += distances.get(route.get(i) + " to " + route.get(i + 1));
            }

            if (sum < shortest) shortest = sum;
        }

        return shortest;
    }

    private static void parseInput(List<String> input, Set<String> cities, Map<String, Integer> distances) {
        for (String in : input) {
            String[] step1 = in.split(" = ");
            String[] c = step1[0].split(" to ");

            int dist = Integer.parseInt(step1[1]);
            distances.put(step1[0], dist);
            distances.put(c[1] + " to " + c[0], dist);

            cities.add(c[0]);
            cities.add(c[1]);
        }
    }

    private static void setUp() {
        // No matter which part gets called first, it'll perform the set up
        // only once. Once the set up is in memory we don't need to set up
        // and permute again.
        if (isSetUp) return;

        List<String> input = Utility.getMultilineInput("src/two/thousand/fifteen/day09/input.prod");
        Set<String> cities = new HashSet<>();
        distances = new HashMap<>();

        parseInput(input, cities, distances);

        allRoutes = Utility.permute(cities);

        isSetUp = true;
    }
}
