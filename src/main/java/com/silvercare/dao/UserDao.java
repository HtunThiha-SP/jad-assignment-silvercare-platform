package com.silvercare.dao;

import com.silvercare.dto.UserRegisterDto;
import com.silvercare.util.Db;
import com.silvercare.util.OperationResponse;

import java.sql.*;

public class UserDao {
	public static OperationResponse insertNewUser(UserRegisterDto userRegisterData) {
		boolean success = false;
		String message = "";
		String code = "";
		Integer newUserId = null;
		
		try {
			Connection conn = Db.getConnection();
			String sqlStatement = "INSERT INTO user(username, email, display_name, password, role_id)"
					+ "VALUES (?, ?, ?, ?, 1)";
			PreparedStatement stmt = conn.prepareStatement(sqlStatement, Statement.RETURN_GENERATED_KEYS);
			
			stmt.setString(1, userRegisterData.getUsername());
			stmt.setString(2, userRegisterData.getEmail());
			stmt.setString(3, userRegisterData.getDisplayName());
			stmt.setString(4, userRegisterData.getPassword());
			
			int rowsAffected = stmt.executeUpdate();
			
			if(rowsAffected == 1) {
				success = true;
				code = "REGISTER_SUCCESS";
				ResultSet rs = stmt.getGeneratedKeys();
				if(rs.next()) {
					newUserId = rs.getInt(1);
				}
			} else {
				success = false;
				code = "REGISTER_UNKNOWN_ERROR";
			}
			
			conn.close();
		} catch(SQLException e) {
	        System.out.println("SQLException at UserDao.insertNewUser");
	        System.out.println("SQL Error Code: " + e.getErrorCode());
	        System.out.println("SQL State: " + e.getSQLState());
	        System.out.println("SQL Message: " + e.getMessage());

			success = false;
	        if (e.getErrorCode() == 1062) {
	            if (e.getMessage().contains("username")) {
	                code = "REGISTER_DUPLICATE_USERNAME";
	            } else if (e.getMessage().contains("email")) {
	                code = "REGISTER_DUPLICATE_EMAIL";
	            } else {
	            	code = "REGISTER_UNKNOWN_ERROR";
	            }
	        } else {
	        	code = "REGISTER_UNKNOWN_ERROR";
	        }
		}
		
		return new OperationResponse(success, message, code, newUserId);
	}
}
