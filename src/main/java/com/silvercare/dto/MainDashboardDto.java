package com.silvercare.dto;

public class MainDashboardDto {
    private int userCount;
    private int appointmentCount;
    private double monthlyIncome;
    private String topServiceCategory;
    
    public MainDashboardDto() { }

	public MainDashboardDto(int userCount, int appointmentCount, double monthlyIncome, String topServiceCategory) {
		this.userCount = userCount;
		this.appointmentCount = appointmentCount;
		this.monthlyIncome = monthlyIncome;
		this.topServiceCategory = topServiceCategory;
	}

	public int getUserCount() {
		return userCount;
	}

	public void setUserCount(int userCount) {
		this.userCount = userCount;
	}

	public int getAppointmentCount() {
		return appointmentCount;
	}

	public void setAppointmentCount(int appointmentCount) {
		this.appointmentCount = appointmentCount;
	}

	public double getMonthlyIncome() {
		return monthlyIncome;
	}

	public void setMonthlyIncome(double monthlyIncome) {
		this.monthlyIncome = monthlyIncome;
	}

	public String getTopServiceCategory() {
		return topServiceCategory;
	}

	public void setTopServiceCategory(String topServiceCategory) {
		this.topServiceCategory = topServiceCategory;
	}
}
