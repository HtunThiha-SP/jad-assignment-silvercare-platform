package com.silvercare.dto;

public class UserUpdateDto {
	private String username;
	private String email;
	private String displayName;

	public UserUpdateDto(String username, String email, String displayName) {
		this.username = username;
		this.email = email;
		this.displayName = displayName;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getDisplayName() {
		return displayName;
	}

	public void setDisplayName(String displayName) {
		this.displayName = displayName;
	}
}
