package com.silvercare.dao;

import com.silvercare.dto.UserLoginDto;
import com.silvercare.dto.UserRegisterDto;
import com.silvercare.util.Db;
import com.silvercare.util.OperationResponse;
import com.silvercare.util.PasswordUtil;

import java.sql.*;
import java.util.*;

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
	
	public static OperationResponse verifyUserLogin(UserLoginDto userLoginData) {
		boolean success = false;
		String message = "";
		String code = "";
		Map<String, Object> responseData = new HashMap<>();
		
		try {
			Connection conn = Db.getConnection();
			String sqlStatement = "SELECT id, display_name, password FROM user WHERE username = ? LIMIT 1";
			PreparedStatement stmt = conn.prepareStatement(sqlStatement);
			
			stmt.setString(1, userLoginData.getUsername());
			
			ResultSet rs = stmt.executeQuery();
			
			if(rs.next()) {
				String dbHash = rs.getString("password");
				String loginPassword = userLoginData.getPassword();
				
				boolean isCorrectPassword = PasswordUtil.verifyPassword(loginPassword, dbHash);
				
				if(isCorrectPassword) {
					success = true;
					code = "LOGIN_SUCCESS";
					responseData.put("userId", rs.getInt("id"));
					responseData.put("displayName", rs.getString("display_name"));
				} else {
					success = false;
					code = "LOGIN_INCORRECT_PASSWORD";
				}
			} else {
				success = false;
				code = "LOGIN_USERNAME_NOT_FOUND";
			}
			
			conn.close();
		} catch(SQLException e) {
	        System.out.println("SQLException at UserDao.verifyUserLogin");
	        System.out.println("SQL Error Code: " + e.getErrorCode());
	        System.out.println("SQL State: " + e.getSQLState());
	        System.out.println("SQL Message: " + e.getMessage());

			success = false;
			code = "LOGIN_UNKNOWN_ERROR";
		}
		
		return new OperationResponse(success, message, code, responseData);
	}
}
