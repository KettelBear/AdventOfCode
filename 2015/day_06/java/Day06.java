package two.thousand.fifteen.day06;

import two.thousand.fifteen.Utility;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class Day06 {
    public static String partOne() {
        ArrayList<String> inputs = Utility.getMultilineInput("src/two/thousand/fifteen/day06/input.prod");

        Map<String, Boolean> grid = new HashMap<>();
        for (String input : inputs) {
            String instruction = parseInstruction(input);
            List<Integer> coordinates = parseCoordinates(input);

            switch (instruction) {
                case "on" -> turnOn(grid, coordinates);
                case "toggle" -> toggle(grid, coordinates);
                case "off" -> turnOff(grid, coordinates);
            }
        }

        int lightsOn = 0;
        for (Map.Entry<String, Boolean> entry : grid.entrySet()) {
            if (entry.getValue()) lightsOn++;
        }

        return Integer.toString(lightsOn);
    }

    public static String partTwo() {
        ArrayList<String> inputs = Utility.getMultilineInput("src/two/thousand/fifteen/day06/input.prod");

        Map<String, Integer> grid = new HashMap<>();
        for (String input : inputs) {
            String instruction = parseInstruction(input);
            List<Integer> coordinates = parseCoordinates(input);

            switch (instruction) {
                case "on" -> brightnessOne(grid, coordinates);
                case "toggle" -> brightnessTwo(grid, coordinates);
                case "off" -> dimnessOne(grid, coordinates);
            }
        }

        int brightness = 0;
        for (Map.Entry<String, Integer> entry : grid.entrySet()) {
            if (entry.getValue() < 0) System.out.println(entry.getValue());
            brightness += entry.getValue();
        }

        return Integer.toString(brightness);
    }

    private static String parseInstruction(String input) {
        if (input.contains("turn on")) return "on";
        if (input.contains("toggle")) return "toggle";
        else return "off";
    }

    private static List<Integer> parseCoordinates(String input) {
        String[] pieces = input.split(" ");

        List<Integer> coordinates = new ArrayList<>();

        for (String piece : pieces) {
            if (piece.contains(",")) {
                String[] tmp = piece.split(",");
                for (String t : tmp) {
                    coordinates.add(Integer.parseInt(t));
                }
            }
        }

        return coordinates;
    }

    private static void turnOn(Map<String, Boolean> grid, List<Integer> coordinates) {
        for (int x = coordinates.get(0); x <= coordinates.get(2); x++) {
            for (int y = coordinates.get(1); y <= coordinates.get(3); y++) {
                grid.put(x + "," + y, true);
            }
        }
    }

    private static void toggle(Map<String, Boolean> grid, List<Integer> coordinates) {
        for (int x = coordinates.get(0); x <= coordinates.get(2); x++) {
            for (int y = coordinates.get(1); y <= coordinates.get(3); y++) {
                String coordinate = x + "," + y;
                if (grid.get(coordinate) == null) {
                    grid.put(coordinate, true);
                } else {
                    grid.put(x + "," + y, !grid.get(x + "," + y));
                }
            }
        }
    }

    private static void turnOff(Map<String, Boolean> grid, List<Integer> coordinates) {
        for (int x = coordinates.get(0); x <= coordinates.get(2); x++) {
            for (int y = coordinates.get(1); y <= coordinates.get(3); y++) {
                grid.put(x + "," + y, false);
            }
        }
    }

    private static void brightnessOne(Map<String, Integer> grid, List<Integer> coordinates) {
        for (int x = coordinates.get(0); x <= coordinates.get(2); x++) {
            for (int y = coordinates.get(1); y <= coordinates.get(3); y++) {
                String coordinate = x + "," + y;
                grid.merge(coordinate, 1, Integer::sum);
            }
        }
    }

    private static void brightnessTwo(Map<String, Integer> grid, List<Integer> coordinates) {
        for (int x = coordinates.get(0); x <= coordinates.get(2); x++) {
            for (int y = coordinates.get(1); y <= coordinates.get(3); y++) {
                String coordinate = x + "," + y;
                grid.merge(coordinate, 2, Integer::sum);
            }
        }
    }

    private static void dimnessOne(Map<String, Integer> grid, List<Integer> coordinates) {
        for (int x = coordinates.get(0); x <= coordinates.get(2); x++) {
            for (int y = coordinates.get(1); y <= coordinates.get(3); y++) {
                String coordinate = x + "," + y;
                if (grid.get(coordinate) == null || grid.get(coordinate) == 0) continue;

                grid.put(coordinate, grid.get(coordinate) - 1);
            }
        }
    }
}
