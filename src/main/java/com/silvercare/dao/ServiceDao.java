package com.silvercare.dao;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.silvercare.dto.ServiceDto;
import com.silvercare.util.Db;
import com.silvercare.util.TimeUtil;

public class ServiceDao {
	public static List<ServiceDto> selectServicesByCategoryName(String serviceCategoryName) {
		var servicesList = new ArrayList<ServiceDto>();
		try {
			Connection conn = Db.getConnection();
			
			String sqlStatement = "SELECT name, title, description, price, img_index, duration, created_on, last_updated_on FROM service "
					+ "WHERE category_id = (SELECT id FROM service_category WHERE name = ?)";
			PreparedStatement stmt = conn.prepareStatement(sqlStatement);
			stmt.setString(1, serviceCategoryName);
			
			ResultSet rs = stmt.executeQuery();
			
			while(rs.next()) {
				String name = rs.getString("name");
				String title = rs.getString("title");
				String description = rs.getString("description");
				double price = rs.getFloat("price");
				int imgIndex = rs.getInt("img_index");
				String durationStr = TimeUtil.convertDuration(rs.getInt("duration"));
				String createdTime = TimeUtil.convertDate(rs.getString("created_on"));
				String lastUpdatedTime = TimeUtil.convertDate(rs.getString("last_updated_on"));
				servicesList.add(new ServiceDto(name, title, description, price, imgIndex, durationStr, createdTime, lastUpdatedTime));
			}
			conn.close();
		} catch(SQLException e) {
	        System.out.println("SQLException at ServiceDao.selectServicesByCategoryName");
	        System.out.println("SQL Error Code: " + e.getErrorCode());
	        System.out.println("SQL State: " + e.getSQLState());
	        System.out.println("SQL Message: " + e.getMessage());
		}
		
		return servicesList;
	}
	
	public static ServiceDto selectServiceByName(String serviceName) {
		String name = "";
		String title = "";
		String description = "";
		double price = 0;
		int imgIndex = 0;
		String durationStr = "";
		String createdTime = "";
		String lastUpdatedTime = "";

		try {
			Connection conn = Db.getConnection();
			
			String sqlStatement = "SELECT name, title, description, price, img_index, duration, created_on, last_updated_on FROM service "
					+ "WHERE name = ?";
			PreparedStatement stmt = conn.prepareStatement(sqlStatement);
			stmt.setString(1, serviceName);
			
			ResultSet rs = stmt.executeQuery();
			
			while(rs.next()) {
				name = rs.getString("name");
				title = rs.getString("title");
				description = rs.getString("description");
				price = rs.getFloat("price");
				imgIndex = rs.getInt("img_index");
				durationStr = TimeUtil.convertDuration(rs.getInt("duration"));
				createdTime = TimeUtil.convertDate(rs.getString("created_on"));
				lastUpdatedTime = TimeUtil.convertDate(rs.getString("last_updated_on"));
			}
			conn.close();
		} catch(SQLException e) {
	        System.out.println("SQLException at ServiceDao.selectServicesByCategoryName");
	        System.out.println("SQL Error Code: " + e.getErrorCode());
	        System.out.println("SQL State: " + e.getSQLState());
	        System.out.println("SQL Message: " + e.getMessage());
		}

		return new ServiceDto(name, title, description, price, imgIndex, durationStr, createdTime, lastUpdatedTime);
	}
}