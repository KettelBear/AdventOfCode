package two.thousand.fifteen.day04;

import java.math.BigInteger;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class Day04 {
    private static final String INPUT = "iwrupvqb";

    public static String partOne() {
        return findMd5WithPrefix(INPUT, "00000");
    }

    public static String partTwo() {
        return findMd5WithPrefix(INPUT, "000000");
    }

    private static String findMd5WithPrefix(String input, String prefix) {
        int i = 0;
        while(!getMd5(input + i).startsWith(prefix)) {
            i++;
        }
        return Integer.toString(i);
    }

    /**
     * Found some MD5 hashing algorithm online.
     */
    private static String getMd5(String input)
    {
        MessageDigest md = null;
        try {
            // Static getInstance method is called with hashing MD5
            md = MessageDigest.getInstance("MD5");
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException(e);
        }

        // digest() method is called to calculate message digest
        //  of an input digest() return array of byte
        byte[] messageDigest = md.digest(input.getBytes());

        // Convert byte array into signum representation
        BigInteger no = new BigInteger(1, messageDigest);

        // Convert message digest into hex value
        StringBuilder hashText = new StringBuilder(no.toString(16));
        while (hashText.length() < 32) {
            hashText.insert(0, "0");
        }

        return hashText.toString();
    }
}
