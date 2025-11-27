package com.silvercare.dao;

import java.sql.*;

import com.silvercare.dto.AdminDashboardDto;
import com.silvercare.util.Db;

public class AdminDashboardDao {
    public static AdminDashboardDto selectMainDashboardData() {
        var adminDashboardData = new AdminDashboardDto();
        try {
        	Connection conn = Db.getConnection();

            Statement userCountStmt = conn.createStatement();
            ResultSet userCountRs = userCountStmt.executeQuery("SELECT COUNT(id) AS user_count FROM user "
            		+ "WHERE role_id != 2");
            while(userCountRs.next()) {
            	adminDashboardData.setUserCount(userCountRs.getInt("user_count"));
            }

            Statement appointmentCountStmt = conn.createStatement();
            ResultSet appointmentCountRs = appointmentCountStmt.executeQuery("SELECT COUNT(id) AS appointment_count "
                    + "FROM appointment");
            while(appointmentCountRs.next()) {
                adminDashboardData.setAppointmentCount(appointmentCountRs.getInt("appointment_count"));
            }

            Statement monthlyRevenueStmt = conn.createStatement();
            ResultSet monthlyRevenueRs = monthlyRevenueStmt.executeQuery("SELECT SUM(s.pricing) AS monthly_revenue "
                    + "FROM appointment a "
                    + "JOIN service s ON a.service_id = s.id "
                    + "WHERE MONTH(a.starts_on) = MONTH(CURRENT_DATE()) "
                    + "AND YEAR(a.starts_on) = YEAR(CURRENT_DATE())");
            while (monthlyRevenueRs.next()) {
                adminDashboardData.setMonthlyIncome(monthlyRevenueRs.getFloat("monthly_revenue"));
            }

            Statement topCategoryStmt = conn.createStatement();
            ResultSet topCategoryRs = topCategoryStmt.executeQuery("SELECT sc.name, COUNT(*) AS total_appointments "
                    + "FROM appointment a "
                    + "JOIN service s ON a.service_id = s.id "
                    + "JOIN service_category sc ON s.category_id = sc.id "
                    + "GROUP BY sc.id, sc.name "
                    + "ORDER BY total_appointments DESC "
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
