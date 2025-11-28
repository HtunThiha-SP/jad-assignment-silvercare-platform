package com.silvercare.controller;

import com.silvercare.dao.UserDao;
import com.silvercare.dto.UserLoginDto;
import com.silvercare.dto.UserRegisterDto;
import com.silvercare.dto.UserUpdateDto;
import com.silvercare.util.OperationResponse;
import com.silvercare.util.PasswordUtil;

public class UserController {
	public static OperationResponse register(String username, String email, String displayName, String password) {
		boolean success = false;
		String message = "";
		String code = "";
		Integer newUserId = null;
		
        if (password == null || password.isEmpty()) {
        	success = false;
        	message = "Empty or invalid password. Please try again.";
        }
        
        if(!username.matches("^[A-Za-z0-9]+(?:-[A-Za-z0-9]+)*$") || username.length() < 8 || username.length() > 32) {
        	success = false;
        	message = "Invalid username format, please try again.";
        }

        String hash = PasswordUtil.hashPassword(password);
		var userRegisterData = new UserRegisterDto(username, email, displayName, hash);
		
		OperationResponse registerSqlResponse = UserDao.insertNewUser(userRegisterData);
		code = registerSqlResponse.getCode();
		
		if(registerSqlResponse.isSuccess()) {
			success = true;
			message = "Redirecting to homepage...";
			newUserId = (Integer) registerSqlResponse.getResponseData();
		} else {
			success = false;
			if(registerSqlResponse.getCode().equals("REGISTER_DUPLICATE_USERNAME")) {
				message = "Username already exists. Please try again.";
			} else if (registerSqlResponse.getCode().equals("REGISTER_DUPLICATE_EMAIL")) {
				message = "Email already exists. Please try again.";
			} else {
				message = "Unknown error occurred. Please try again.";
			}
		}
		
		return new OperationResponse(success, message, code, newUserId);
	}
	
	public static OperationResponse loginUser(String username, String password) {
		boolean success = false;
		String message = "";
		String code = "";

        if (password == null || password.isEmpty()) {
        	success = false;
        	message = "Empty or invalid password. Please try again.";
        }
        
        if(!username.matches("^[A-Za-z0-9]+(?:-[A-Za-z0-9]+)*$") || username.length() < 8 || username.length() > 32) {
        	success = false;
        	message = "Invalid username format, please try again.";
        }

		var userLoginData = new UserLoginDto(username, password);
		
		OperationResponse loginSqlResponse = UserDao.verifyUserLogin(userLoginData);
		code = loginSqlResponse.getCode();
		
		if(loginSqlResponse.isSuccess()) {
			success = true;
			message = "Redirecting to homepage...";
		} else {
			success = false;
			if(loginSqlResponse.getCode().equals("LOGIN_USERNAME_NOT_FOUND")) {
				message = "Username not found. Please try again.";
			} else if (loginSqlResponse.getCode().equals("LOGIN_INCORRECT_PASSWORD")) {
				message = "Incorrect password. Please try again.";
			} else {
				message = "Unknown error occurred. Please try again.";
			}
		}
		
		return new OperationResponse(success, message, code, loginSqlResponse.getResponseData());
	}
	
    public static UserUpdateDto getUserProfileInfo(Integer userId) {
        return UserDao.selectUserById(userId);
    }

	public static OperationResponse updateUserProfile(String username, String email, String displayName, int userId) {
		boolean success = false;
		String message = "";
		String code = "";
		
        if (displayName == null || displayName.isEmpty()) {
            displayName = username;
        }
        
        if(!username.matches("^[A-Za-z0-9]+(?:-[A-Za-z0-9]+)*$") || username.length() < 8 || username.length() > 32) {
        	success = false;
        	message = "Invalid username format, please try again.";
        }

		var userUpdateData = new UserUpdateDto(username, email, displayName);
		
		OperationResponse updateSqlResponse = UserDao.updateUserByUserId(userUpdateData, userId);
		code = updateSqlResponse.getCode();
		
		if(updateSqlResponse.isSuccess()) {
			success = true;
			message = "Refreshing user profile...";
		} else {
			success = false;
			if(updateSqlResponse.getCode().equals("UPDATE_DUPLICATE_USERNAME")) {
				message = "Username already exists. Please try again.";
			} else if (updateSqlResponse.getCode().equals("UPDATE_DUPLICATE_EMAIL")) {
				message = "Email already exists. Please try again.";
			} else {
				message = "Unknown error occurred. Please try again.";
			}
		}
		
		return new OperationResponse(success, message, code);
	}
	
	public static OperationResponse updateUserPassword(String oldPassword, String newPassword, Integer userId) {
		boolean success = false;
		String message = "";
		String code = "";
		
		OperationResponse updateSqlResponse = UserDao.updateUserPasswordByUserId(oldPassword, newPassword, userId);
		code = updateSqlResponse.getCode();
		
		if(updateSqlResponse.isSuccess()) {
			success = true;
			message = "Refreshing user profile...";
		} else {
			success = false;
			if(updateSqlResponse.getCode().equals("UPDATE_INCORRECT_PASSWORD")) {
				message = "Current password is incorrect. Please try again.";
			} else {
				message = "Unknown error occurred. Please try again.";
			}
		}
		
		return new OperationResponse(success, message, code);
	}
}
