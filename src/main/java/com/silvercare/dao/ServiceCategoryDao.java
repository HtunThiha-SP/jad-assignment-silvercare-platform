package com.silvercare.dao;

import com.silvercare.model.ServiceCategory;
import com.silvercare.util.Db;

import java.util.*;
import java.sql.*;

public class ServiceCategoryDao {
	public static List<ServiceCategory> selectAllServiceCategories() {
		List<ServiceCategory> serviceCategoriesList = new ArrayList<>();
		
		try {
			Connection conn = Db.getConnection();
			Statement stmt = conn.createStatement();
			String sqlQuery = "SELECT name, description, img_index "
					+ "FROM service_category";
			
			ResultSet rs = stmt.executeQuery(sqlQuery);
			
			while(rs.next()) {
				String name = rs.getString("name");
				String description = rs.getString("description");
				int imgIndex = rs.getInt("img_index");
				
				serviceCategoriesList.add(new ServiceCategory(name, description, imgIndex));
			}
			
			conn.close();
		} catch (SQLException e) {
			System.out.println("SQLException at ServiceCategoryDao.selectAllServiceCategories");
	        System.out.println("SQL Error Code: " + e.getErrorCode());
	        System.out.println("SQL State: " + e.getSQLState());
	        System.out.println("SQL Message: " + e.getMessage());
		}
		
		return serviceCategoriesList;
	}
}
