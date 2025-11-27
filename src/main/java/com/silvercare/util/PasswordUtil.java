package com.silvercare.util;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.util.Base64;
import java.util.Arrays;

public class PasswordUtil {

    private static final int SALT_LENGTH = 16;

    public static String hashPassword(String plainPassword) {
        byte[] salt = generateSalt();
        byte[] hash = hash(plainPassword, salt);
        byte[] saltAndHash = new byte[salt.length + hash.length];
        System.arraycopy(salt, 0, saltAndHash, 0, salt.length);
        System.arraycopy(hash, 0, saltAndHash, salt.length, hash.length);
        return Base64.getEncoder().encodeToString(saltAndHash);
    }

    public static boolean verifyPassword(String plainPassword, String storedHash) {
        byte[] saltAndHash = Base64.getDecoder().decode(storedHash);
        byte[] salt = Arrays.copyOfRange(saltAndHash, 0, SALT_LENGTH);
        byte[] hash = Arrays.copyOfRange(saltAndHash, SALT_LENGTH, saltAndHash.length);
        byte[] inputHash = hash(plainPassword, salt);
        return Arrays.equals(hash, inputHash);
    }

    private static byte[] generateSalt() {
        SecureRandom sr = new SecureRandom();
        byte[] salt = new byte[SALT_LENGTH];
        sr.nextBytes(salt);
        return salt;
    }

    private static byte[] hash(String password, byte[] salt) {
    	try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            md.update(salt);
        return md.digest(password.getBytes());
    	} catch (NoSuchAlgorithmException e) {
    		System.out.print("Error on password hashing: " + e.getMessage());
    	}
    	return null;
    }
}