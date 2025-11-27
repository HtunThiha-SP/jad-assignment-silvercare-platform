package com.silvercare.util;

import java.time.LocalDateTime;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;

public class TimeUtil {

    private static final DateTimeFormatter INPUT_FORMAT = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
    private static final DateTimeFormatter DATE_FORMAT = DateTimeFormatter.ofPattern("d MMM yyyy");
    private static final DateTimeFormatter DATETIME_FORMAT = DateTimeFormatter.ofPattern("d MMM yyyy h:mma");

    public static String convertDate(String timeString) {
        try {
            LocalDate date = LocalDateTime.parse(timeString, INPUT_FORMAT).toLocalDate();
            return date.format(DATE_FORMAT);
        } catch (DateTimeParseException e) {
            e.printStackTrace();
            return timeString;
        }
    }

    public static String convertDateTime(String timeString) {
        try {
            LocalDateTime dateTime = LocalDateTime.parse(timeString, INPUT_FORMAT);
            return dateTime.format(DATETIME_FORMAT);
        } catch (DateTimeParseException e) {
            e.printStackTrace();
            return timeString;
        }
    }
    
    public static String convertDuration(int seconds) {
        int hours = seconds / 3600;
        int minutes = (seconds % 3600) / 60;
        StringBuilder sb = new StringBuilder();
        if (hours > 0) sb.append(hours).append("h");
        if (minutes > 0) sb.append(minutes).append("m");
        if (hours == 0 && minutes == 0) sb.append("0m");
        return sb.toString();
    }
}