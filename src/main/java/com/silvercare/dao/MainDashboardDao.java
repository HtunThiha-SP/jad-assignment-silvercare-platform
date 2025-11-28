package com.silvercare.dao;

import java.sql.*;

import com.silvercare.dto.MainDashboardDto;
import com.silvercare.util.Db;

public class MainDashboardDao {
    public static MainDashboardDto selectMainDashboardData() {
        var adminDashboardData = new MainDashboardDto();
        try {
        	Connection conn = Db.getConnection();

            Statement userCountStmt = conn.createStatement();
            ResultSet userCountRs = userCountStmt.executeQuery("SELECT COUNT(id) AS user_count FROM user "
            		+ "WHERE role_id != 2");
            while(userCountRs.next()) {
            	adminDashboardData.setUserCount(userCountRs.getInt("user_count"));
            }

            Statement bookingCountStmt = conn.createStatement();
            ResultSet bookingCountRs = bookingCountStmt.executeQuery("SELECT COUNT(id) AS booking_count "
                    + "FROM booking");
            while(bookingCountRs.next()) {
                adminDashboardData.setBookingCount(bookingCountRs.getInt("booking_count"));
            }

            Statement monthlyRevenueStmt = conn.createStatement();
            ResultSet monthlyRevenueRs = monthlyRevenueStmt.executeQuery("SELECT SUM(s.price) AS monthly_revenue "
                    + "FROM booking b "
                    + "JOIN service s ON b.service_id = s.id "
                    + "WHERE MONTH(b.appointment_on) = MONTH(CURRENT_DATE()) "
                    + "AND YEAR(b.appointment_on) = YEAR(CURRENT_DATE())");
            while (monthlyRevenueRs.next()) {
                adminDashboardData.setMonthlyIncome(monthlyRevenueRs.getFloat("monthly_revenue"));
            }

            Statement topCategoryStmt = conn.createStatement();
            ResultSet topCategoryRs = topCategoryStmt.executeQuery("SELECT sc.name, COUNT(*) AS total_bookings "
                    + "FROM booking b "
                    + "JOIN service s ON b.service_id = s.id "
                    + "JOIN service_category sc ON s.category_id = sc.id "
                    + "GROUP BY sc.id, sc.name "
                    + "ORDER BY total_bookings DESC "
                    + "LIMIT 1");
            while (topCategoryRs.next()) {
                adminDashboardData.setTopServiceCategory(topCategoryRs.getString("name"));
            }
            
            conn.close();
        } catch(SQLException e) {
			System.out.println("SQLException at AdminDashboardDto.selectMainDashboardData");
	        System.out.println("SQL Error Code: " + e.getErrorCode());
	        System.out.println("SQL State: " + e.getSQLState());
	        System.out.println("SQL Message: " + e.getMessage());
        }

        return adminDashboardData;
    }
}
