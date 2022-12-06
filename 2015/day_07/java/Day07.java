package two.thousand.fifteen.day07;

import two.thousand.fifteen.Utility;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class Day07 {
    public static String partOne(String in_file) {
        String filepath = "src/two/thousand/fifteen/day07/input.prod";
        if (in_file != null) filepath = in_file;

        List<String> inputs = Utility.getMultilineInput(filepath);

        Map<String, String> wireValues = new HashMap<>();
        for (String input : inputs) {
            String[] components = input.split(" -> ");
            wireValues.put(components[1], components[0]);
        }

        Map<String, Integer> lookup = new HashMap<>();
        return Integer.toString(followPath(wireValues, "a", lookup));
    }

    public static String partTwo() {
        return partOne("src/two/thousand/fifteen/day07/input2.prod");
    }

    private static int followPath(Map<String, String> wires, String key, Map<String, Integer> lookup) {
        int value = 0;
        try {
            return Short.parseShort(key);
        } catch (NumberFormatException e) {
            // Do nothing
        }

        if (lookup.containsKey(key)) return lookup.get(key);

        try {
            value = Short.parseShort(wires.get(key));
        } catch (NumberFormatException e) {
            String instruction = wires.get(key);
            String op = getBitwiseOp(instruction);

            String[] pieces;
            switch (op) {
                case "&" -> {
                    pieces = instruction.split(" ");
                    value = (followPath(wires, pieces[0], lookup) & followPath(wires, pieces[2], lookup));
                }
                case "<<" -> {
                    pieces = instruction.split(" ");
                    value = (followPath(wires, pieces[0], lookup) << Integer.parseInt(pieces[2]));
                }
                case ">>" -> {
                    pieces = instruction.split(" ");
                    value = (followPath(wires, pieces[0], lookup) >> Integer.parseInt(pieces[2]));
                }
                case "~" -> {
                    pieces = instruction.split(" ");
                    value = ~followPath(wires, pieces[1], lookup);
                }
                case "|" -> {
                    pieces = instruction.split(" ");
                    value = (followPath(wires, pieces[0], lookup) | followPath(wires, pieces[2], lookup));
                }
                default -> {
                    value = followPath(wires, instruction, lookup);
                }
            }
        }

        final int clean = value & 0xFFFF;
        lookup.put(key, clean);

        return clean;
    }

    private static String getBitwiseOp(String instruction) {
        if (instruction.contains("AND")) return "&";
        if (instruction.contains("LSHIFT")) return "<<";
        if (instruction.contains("RSHIFT")) return ">>";
        if (instruction.contains("NOT")) return "~";
        if (instruction.contains("OR")) return "|";

        return "";
    }
}
