<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.silvercare.dto.ServiceDto" %>
<%@ page import="com.silvercare.controller.ServiceController" %>
<%@ page import="com.silvercare.dto.CaregiverDto" %>
<%@ page import="com.silvercare.controller.CaregiverController" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@ include file="./components/header-config.html" %>
<title>SilverCare | Service</title>
</head>
<body>
<jsp:include page="./components/navBar.jsp"></jsp:include>
<%
	String serviceName = request.getParameter("name");
	var serviceDetails = ServiceController.getServiceByName(serviceName);
	
	String name = serviceDetails.getName();
	String title = serviceDetails.getTitle();
	String description = serviceDetails.getDescription();
	double price = serviceDetails.getPrice();
	String duration = serviceDetails.getDurationStr();
	String createdTime = serviceDetails.getCreatedTime();
	String updatedTime = serviceDetails.getLastUpdatedTime();
	int imgIndex = serviceDetails.getImgIndex();
%>
<div class="container py-5">
    <div class="row mb-5">
        <div class="col-12 col-md-6">
            <img src="./img/service-<%= imgIndex %>-banner.png" class="img-fluid rounded" alt="Service Image">
        </div>
        <div class="col-12 col-md-6">
            <h3 id="serviceName"><i class="bi bi-clipboard-heart"></i>&ensp;<%= name %></h3>
            <p id="serviceDescription">
				<%= description %>
            </p>
            <ul class="list-group list-group-flush mb-3">
                <li class="list-group-item"><strong><span id="serviceTitle"><i class="bi bi-emoji-heart-eyes"></i>&ensp;<%= title %></span></strong></li>
                <li class="list-group-item"><strong><i class="bi bi-cash-coin"></i>&ensp;Price:</strong> $<span id="servicePrice"><%= price %></span></li>
                <li class="list-group-item"><strong><i class="bi bi-stopwatch"></i>&ensp;Duration:</strong> <span id="serviceDuration"><%= duration %></span></li>
                <li class="list-group-item"><strong><i class="bi bi-calendar2-week"></i>&ensp;Service Offered On:</strong> <span id="serviceCreated"><%= createdTime %></span></li>
                <li class="list-group-item"><strong><i class="bi bi-calendar2-week"></i>&ensp;Last Updated:</strong> <span id="serviceUpdated"><%= updatedTime %></span></li>
            </ul>
        </div>
    </div>

    <div class="row">
        <div class="col-12">
            <h2 class="mb-4">Available Caregivers</h2>
        </div>
        <% 
        	var caregiversList = CaregiverController.getCaregiversByServiceName(serviceName);
        	for(CaregiverDto caregiver : caregiversList) {
        		out.print("<div class='col-12 col-md-6 col-lg-4 mb-4'>"
        		          + "<div class='card h-100 shadow-sm'>"
        		          + "<div class='card-body'>"
        		          + "<h5 class='card-title text-success'><i class=\"bi bi-person-badge\"></i>&ensp;" + caregiver.getName() +"</h5>"
        		          + "<p class='card-text'><strong><i class=\"bi bi-patch-check\"></i>&ensp;Qualifications:</strong>&ensp;" + caregiver.getQualifications() + "<br>"
        		          + "<strong><i class=\"bi bi-calendar-check\"></i>&ensp;Service since:</strong>&ensp;" + caregiver.getJoinedTime() + "</p>"
        		          + "</div>"
        		          + "</div>"
        		          + "</div>");
        	}
        %>
    </div>
</div>
<%@ include file="./components/footer.html" %>
</body>
</html>