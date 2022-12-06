package two.thousand.fifteen.day14;

import two.thousand.fifteen.Utility;

import java.util.ArrayList;
import java.util.List;

public class Day14 {
    private static final double RACE_TIME = 2503.0;

    public static String partOne() {
        List<String> input = Utility.getMultilineInput("src/two/thousand/fifteen/day14/input.prod");

        int maxDist = 0;
        for (String in : input) {
            String[] details = in.split(" ");
            Reindeer r = new Reindeer(details[0], details[6], details[13], details[3]);

            int travelled = (int) Math.ceil(RACE_TIME / r.cycleTime) * r.flightSpeed * r.flightTime;
            if (travelled > maxDist) maxDist = travelled;
        }

        return String.valueOf(maxDist);
    }

    public static String partTwo() {
        // Dancer has accumulated 689 points
        // Comet, our old champion, only has 312
        //472 too low
        List<String> input = Utility.getMultilineInput("src/two/thousand/fifteen/day14/input.prod");

        List<Reindeer> racers = new ArrayList<>();
        for (String in : input) {
            String[] details = in.split(" ");
            Reindeer r = new Reindeer(details[0], details[6], details[13], details[3]);
            racers.add(r);
        }

        for (int s = 0; s < RACE_TIME; s++) {
            List<Reindeer> leaders = getLeader(racers, s);
            for (Reindeer r : leaders) r.addRacePoint();
        }

        int maxPoints = 0;
        for (Reindeer r : racers) {
            if (r.getRacePoints() > maxPoints) maxPoints = r.getRacePoints();
        }

        return String.valueOf(maxPoints);
    }

    private static List<Reindeer> getLeader(List<Reindeer> racers, int time) {
        List<Reindeer> leaders = new ArrayList<>();
        for (Reindeer r : racers) r.race(time);

        int bestDistance = 0;
        for (Reindeer r : racers) {
            int currDist = r.getDistance();
            if (currDist > bestDistance) {
                leaders = new ArrayList<>();
                leaders.add(r);
                bestDistance = currDist;
            } else if (currDist == bestDistance) {
                leaders.add(r);
            }
        }

        return leaders;
    }

    static class Reindeer {
        public String name;
        public int flightTime;
        public int flightSpeed;
        public int restTime;
        public int cycleTime;
        public int racePoints;
        public int distance;

        public Reindeer(String name, String flightTime, String restTime, String flightSpeed) {
            this.name = name;
            this.flightTime = Integer.parseInt(flightTime);
            this.restTime = Integer.parseInt(restTime);
            this.cycleTime = this.flightTime + this.restTime;
            this.flightSpeed = Integer.parseInt(flightSpeed);
            this.racePoints = 0;
            this.distance = 0;
        }

        public void race(int time) {
            if (time % cycleTime < flightTime){
                this.distance += this.flightSpeed;
            }
        }

        public int getDistance() {
            return this.distance;
        }

        public void addRacePoint() {
            racePoints += 1;
        }

        public int getRacePoints() {
            return this.racePoints;
        }
    }
}
