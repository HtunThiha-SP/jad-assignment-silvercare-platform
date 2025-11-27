package com.silvercare.util;

import java.sql.*;
import java.util.Properties;
import java.io.InputStream;

public class Db {
    private static String driver;
    private static String url;
    private static String user;
    private static String password;

    static {
        loadConfig();
    }

    private static void loadConfig() {
        try (InputStream input = Db.class.getClassLoader().getResourceAsStream("config.properties")) {

            if (input == null) {
                System.out.println("Error loading DB config: Unable to find config.properties.");
                return;
            }

            Properties prop = new Properties();
            prop.load(input);

            driver = prop.getProperty("db.driver");
            url = prop.getProperty("db.url");
            user = prop.getProperty("db.user");
            password = prop.getProperty("db.password");

        } catch (Exception e) {
            System.out.println("Error loading DB config: " + e.getMessage());
        }
    }

    public static Connection getConnection() {
        Connection conn = null;
        try {
            Class.forName(driver);
            conn = DriverManager.getConnection(url, user, password);
        } catch (Exception e) {
            System.out.println("Error connecting DB: " + e.getMessage());
        }

        return conn;
    }
}