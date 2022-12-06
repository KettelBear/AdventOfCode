package two.thousand.fifteen;

import java.io.File;
import java.io.FileNotFoundException;
import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;
import java.util.Set;

/**
 * Adding this class to the 2015 folder because some of the challenges shared
 * steps to solve. So, this class is here so Github can reference these methods
 * shared across solutions for different days.
 */
public class Utility {
    public static String getSingleLineInput(String in_file) {
        File input = new File(in_file);

        Scanner reader = null;
        try {
            reader = new Scanner(input);
        } catch (FileNotFoundException e) {
            e.printStackTrace();
            return "";
        }

        StringBuilder inputStr = new StringBuilder();
        while (reader.hasNextLine()) {
            inputStr.append(reader.nextLine());
        }

        reader.close();

        return inputStr.toString();
    }

    public static List<String> getMultilineInput(String in_file) {
        File input = new File(in_file);

        List<String> inputArr = new ArrayList<>();

        Scanner reader = null;
        try {
            reader = new Scanner(input);
        } catch (FileNotFoundException e) {
            e.printStackTrace();
            return inputArr;
        }

        while (reader.hasNextLine()) {
            inputArr.add(reader.nextLine());
        }

        return inputArr;
    }

    public static List<List<String>> permute(Set<String> cities) {
        List<List<String>> routes = new ArrayList<>();
        String[] cityArray = new String[cities.size()];
        helper(routes, new ArrayList<>(), cities.toArray(cityArray));

        return routes;
    }

    private static void helper(List<List<String>> routes, List<String> route, String[] cities) {
        if (route.size() == cities.length) {
            routes.add(new ArrayList<>(route));
            return;
        }

        for (String city : cities) {
            if (route.contains(city)) {
                continue;
            }

            route.add(city);
            helper(routes, route, cities);
            route.remove(route.size() - 1);
        }
    }
}
