package com.silvercare.dto;

public class CaregiverDto {
    private String name;
    private String qualifications;
    private String joinedTime;

	public CaregiverDto(String name, String qualifications, String joinedTime) {
		this.name = name;
		this.qualifications = qualifications;
		this.joinedTime = joinedTime;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getQualifications() {
		return qualifications;
	}

	public void setQualifications(String qualifications) {
		this.qualifications = qualifications;
	}

	public String getJoinedTime() {
		return joinedTime;
	}

	public void setJoinedTime(String joinedTime) {
		this.joinedTime = joinedTime;
	}
}
