package com.silvercare.service;

import com.silvercare.dao.UserDao;
import com.silvercare.dto.UserRegisterDto;
import com.silvercare.util.OperationResponse;
import com.silvercare.util.PasswordUtil;

public class UserManager {
	public static OperationResponse register(String username, String email, String displayName, String password) {
		boolean success = false;
		String message = "";
		String code = "";
		Integer newUserId = null;
		
        if (displayName == null || displayName.isEmpty()) {
            displayName = username;
        }
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
}
