package com.silvercare.dto;

public class MainDashboardDto {
    private int userCount;
    private int bookingCount;
    private double monthlyIncome;
    private String topServiceCategory;
    
    public MainDashboardDto() { }

	public MainDashboardDto(int userCount, int bookingCount, double monthlyIncome, String topServiceCategory) {
		this.userCount = userCount;
		this.bookingCount = bookingCount;
		this.monthlyIncome = monthlyIncome;
		this.topServiceCategory = topServiceCategory;
	}

	public int getUserCount() {
		return userCount;
	}

	public void setUserCount(int userCount) {
		this.userCount = userCount;
	}

	public int getBookingCount() {
		return bookingCount;
	}

	public void setBookingCount(int bookingCount) {
		this.bookingCount = bookingCount;
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
