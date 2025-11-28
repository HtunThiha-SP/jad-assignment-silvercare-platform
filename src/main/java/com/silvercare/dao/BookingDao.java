package com.silvercare.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import com.silvercare.dto.BookingDto;
import com.silvercare.util.Db;
import com.silvercare.util.TimeUtil;

public class BookingDao {
	public static List<BookingDto> selectBookingsByUserId(int userId) {
		List<BookingDto> bookingsList = new ArrayList<>();
		
		try {
			Connection conn = Db.getConnection();
			String sqlQuery = "SELECT s.name, sc.name AS category, b.appointment_on, b.status, s.price "
					+ "FROM service s "
					+ "JOIN service_category sc ON s.category_id = sc.id "
					+ "JOIN booking b ON b.service_id = s.id "
					+ "WHERE b.user_id = ?";
			
			PreparedStatement stmt = conn.prepareStatement(sqlQuery);
			stmt.setInt(1, userId);
			ResultSet rs = stmt.executeQuery();
			
			while(rs.next()) {
				String name = rs.getString("name");
				String category = rs.getString("category");
				String appointmentTime = TimeUtil.convertDate(rs.getString("appointment_on"));
				String status = rs.getString("status");
				double price = rs.getFloat("price");
				
				bookingsList.add(new BookingDto(name, category, appointmentTime, status, price));
			}
			
			conn.close();
		} catch (SQLException e) {
			System.out.println("SQLException at BookingDao.selectBookingsByUserId");
	        System.out.println("SQL Error Code: " + e.getErrorCode());
	        System.out.println("SQL State: " + e.getSQLState());
	        System.out.println("SQL Message: " + e.getMessage());
		}
		
		return bookingsList;
	}
}
