<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.silvercare.dao.MainDashboardDao"%>
<%@ page import="com.silvercare.dto.MainDashboardDto" %>
<%@ page import="com.silvercare.controller.DashboardController" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <%@ include file="../components/header-config.html" %>
    <title>SilverCare | Admin Dashboard</title>
</head>
<body style="background-color: #F5F5F5;">
    <%@ include file="../components/sessionTimeout.jsp" %>
    <%@ include file="../components/verifyAdminStatus.jsp" %>
    
    <%
    	var adminDashboardData = MainDashboardDao.selectMainDashboardData();
    	int userCount = adminDashboardData.getUserCount();
    	int bookingCount = adminDashboardData.getAppointmentCount();
    	double currentMonthlyRevenue = adminDashboardData.getMonthlyIncome();
    	String topServiceCategory = adminDashboardData.getTopServiceCategory();
    %>

    <div class="container mt-5 mb-5">
        <div class="row mb-4">
            <div class="col-12">
                <h2 style="font-weight: 700; color: #1D3142;">Admin Dashboard</h2>
            </div>
        </div>

        <!-- ====================== BUSINESS ANALYTICS CARDS ====================== -->
        <div class="row g-4 mb-5">
            <div class="col-md-3">
                <div class="card shadow-sm" style="border-radius: 16px;">
                    <div class="card-body">
                        <h6 class="text-muted"><i class="bi bi-person-check-fill"></i>&ensp;Total Users</h6>
                        <h4 style="font-weight:700; color:#1D3142;"><%= userCount %></h4>
                    </div>
                </div>
            </div>

            <div class="col-md-3">
                <div class="card shadow-sm" style="border-radius: 16px;">
                    <div class="card-body">
                        <h6 class="text-muted"><i class="bi bi-ui-checks"></i>&ensp;Total Bookings</h6>
                        <h4 style="font-weight:700; color:#1D3142;"><%= bookingCount %></h4>
                    </div>
                </div>
            </div>

            <div class="col-md-3">
                <div class="card shadow-sm" style="border-radius: 16px;">
                    <div class="card-body">
                        <h6 class="text-muted"><i class="bi bi-cash"></i>&ensp;Current Monthly Revenue</h6>
                        <h4 style="font-weight:700; color:#1D3142;">$&ensp;<%= currentMonthlyRevenue %></h4>
                    </div>
                </div>
            </div>

            <div class="col-md-3">
                <div class="card shadow-sm" style="border-radius: 16px;">
                    <div class="card-body">
                        <h6 class="text-muted"><i class="bi bi-tag-fill"></i>&ensp;Top Service Category</h6>
                        <h5 style="font-weight:700; color:#1D3142;"><%= topServiceCategory %></h5>
                    </div>
                </div>
            </div>
        </div>
        <!-- ===================================================================== -->

        <div class="row g-4">
        	<div class="col-12">
        	    <p class="text-muted">
                    Use the panels below to manage care services and registered users.
                </p>
        	</div>
            <div class="col-md-6">
                <div class="card shadow-sm" style="border-radius: 16px;">
                    <div class="card-body">
                        <h5 class="card-title">Manage Services</h5>
                        <p class="card-text" style="font-size: 14px;">
                            Create, view, update, and remove caregiving services and pricing details.
                        </p>
                        <button class="btn"
                                style="background-color:#2C2C2C; color:white;"
                                onclick="window.location.href='<%= request.getContextPath() %>/services.jsp'">
                            Go to Services
                        </button>
                    </div>
                </div>
            </div>

            <div class="col-md-6">
                <div class="card shadow-sm" style="border-radius: 16px;">
                    <div class="card-body">
                        <h5 class="card-title">Manage Users</h5>
                        <p class="card-text" style="font-size: 14px;">
                            View and manage registered client accounts.
                        </p>
                        <button class="btn"
                                style="background-color:#2C2C2C; color:white;"
                                onclick="window.location.href='<%= request.getContextPath() %>/users.jsp'">
                            Go to Users
                        </button>
                    </div>
                </div>
            </div>
            
            <div class="col-md-6">
                <div class="card shadow-sm" style="border-radius: 16px;">
                    <div class="card-body">
                        <h5 class="card-title">Manage Booking Appointments</h5>
                        <p class="card-text" style="font-size: 14px;">
                            View, edit, and approve customer booking appointments.
                        </p>
                        <button class="btn"
                                style="background-color:#2C2C2C; color:white;"
                                onclick="window.location.href='<%= request.getContextPath() %>/appointments.jsp'">
                            Go to Appointments
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>