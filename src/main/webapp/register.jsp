<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@ include file="../components/header-config.html" %>
<title>SilverCare | Register</title>
</head>
<body style="background-color: #1D3142;">
	<style>
		#login-text:hover {
			cursor: pointer;
			text-decoration: underline;
		}
	</style>
	<%
		Boolean registerSuccess = (Boolean) session.getAttribute("registerSuccess");
		String notificationColor = "#1D3142";
		String notificationMessage = "";
		String registerStatus = "";
		String toastVisibility = "d-none";
		if (registerSuccess != null) {
			String message = (String) session.getAttribute("message");
			toastVisibility = "d-block";
			if (registerSuccess) {
				registerStatus = "Registration Successful";
				notificationColor = "#077307";
				notificationMessage = "<i class=\"bi bi-arrow-up-right-square-fill\"></i>&ensp;" + message;
				out.print("<script>");
				out.print("setTimeout(function() {");
				out.print("window.location.href = '" + request.getContextPath() + "/index.jsp';");
				out.print("}, 1500);");
				out.print("</script>");
			} else {
				notificationColor = "#FF0000";
				registerStatus = "Registration Failed";
				notificationMessage = "<i class=\"bi bi-exclamation-triangle-fill\"></i>&ensp;" + message;
			}
			session.removeAttribute("registerSuccess");
		}
	%>
    <div class="container mt-5">
        <div class="row justify-content-center align-items-center">
            <div class="col-md-6 col-lg-5 mb-4">
                <div class="card p-4">
                    <h2 class="text-center">Register</h2>
                    <form action="<%= request.getContextPath() %>/register" method="post">
                        <div class="mb-3">
                            <label for="username" class="form-label"><i class="bi bi-person-circle"></i>&ensp;Username</label>
                            <input 
                                type="text" 
                                class="form-control" 
                                id="username" 
                                name="username" 
                                placeholder="Enter username" 
                                required
                                minlength="8"
                                maxlength="32"
                                pattern="^[A-Za-z0-9]+(?:-[A-Za-z0-9]+)*$"
                                title="8-32 characters. Only letters, numbers, and single hyphens. Cannot start or end with a hyphen."
                            >
                            <small style="color: gray; font-size: 13px;">
        						Username may only contain alphanumeric characters or single hyphens, and cannot begin or end with a hyphen.
    						</small>
                        </div>
                        <div class="mb-3">
                            <label for="displayName" class="form-label"><i class="bi bi-person-badge"></i>&ensp;Display name (optional)</label>
                            <input type="text" class="form-control" id="displayName" name="displayName" placeholder="Enter display name">
                        </div>
                        <div class="mb-3">
                            <label for="email" class="form-label"><i class="bi bi-envelope-at-fill"></i>&ensp;Email</label>
                            <input type="email" class="form-control" id="email" name="email" placeholder="Enter email" required>
                        </div>
                        <div class="mb-3">
                            <label for="password" class="form-label"><i class="bi bi-person-fill-lock"></i>&ensp;Password</label>
                            <input 
                                type="password" 
                                class="form-control" 
                                id="password" 
                                name="password" 
                                placeholder="Enter password" 
                                required
                                minlength="8"
                                title="Password must be at least 8 characters long."
                            >
                            <small style="color: gray; font-size: 13px;">
        						Password must be at least 8 characters long.
    						</small>
                        </div>
                        <div style="height: 10px;"></div>
                        <button type="submit" class="btn btn-primary w-100">Register account</button>
                        <p class="mt-3">Already have an account? 
                        	<i id="login-text" style="color: blue;" onclick="window.location.href='./login.jsp'">Login</i>
                        </p>
                    </form>
                </div>
            </div>
        </div>
    </div>
	<div class="position-fixed bottom-0 end-0 p-3" style="z-index: 1055;">
	    <div class="toast fade show <%= toastVisibility %>" role="alert" aria-live="assertive" aria-atomic="true">
	        <div class="toast-header">
	            <svg aria-hidden="true" class="bd-placeholder-img rounded me-2" height="20" preserveAspectRatio="xMidYMid slice" width="20" xmlns="http://www.w3.org/2000/svg">
	                <rect width="100%" height="100%" fill="<%= notificationColor %>"></rect>
	            </svg>
	            <strong class="me-auto" style="color: <%= notificationColor %>"><%= registerStatus %></strong>
	            <small class="text-body-secondary">Just now</small>
	            <button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
	        </div>
	        <div class="toast-body">
	            <%= notificationMessage %>
	        </div>
	    </div>
	</div>
</body>
</html>