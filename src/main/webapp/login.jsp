<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@ include file="../components/header-config.html" %>
<title>SilverCare | Login</title>
</head>
<body style="background-color: #1D3142;">
	<style>
		#register-text:hover {
			cursor: pointer;
			text-decoration: underline;
		}
	</style>
	<%
		Boolean loginSuccess = (Boolean) session.getAttribute("loginSuccess");
		String toastVisibility = "d-none";
		String notificationColor = "#1D3142";
		String notificationMessage = "";
		String loginStatus = "";
		if(loginSuccess != null) {
			String message = (String) session.getAttribute("message");
			toastVisibility = "d-block";
			if(loginSuccess) {
				notificationColor = "#077307";
				loginStatus = "Login Successful";
				notificationMessage = "<i class=\"bi bi-arrow-up-right-square-fill\"></i>&ensp;" + message;

				out.print("<script>");
				out.print("setTimeout(function() {");
				out.print("window.location.href = '" + request.getContextPath() + "/index.jsp';");
				out.print("}, 1500);");
				out.print("</script>");
			} else {
				notificationColor = "#FF0000";
				loginStatus = "Login Failed";
				notificationMessage = "<i class=\"bi bi-exclamation-triangle-fill\"></i>&ensp;" + message;
			}
			session.removeAttribute("loginSuccess");
		}
	%>
    <div class="container mt-5">
        <div class="row justify-content-center align-items-center">
            <div class="col-md-6 col-lg-5 col-xl-4 mb-4">
                <div class="card p-4">
                    <h2 class="text-center">Login</h2>
                    <form action="<%= request.getContextPath() %>/verify-user" method="post">
                        <div class="mb-3">
                            <label for="text" class="form-label"><i class="bi bi-person-circle"></i>&ensp;Username</label>
                            <input type="text" class="form-control" id="username" name="username" placeholder="Enter username" required>
                        </div>
                        <div class="mb-3">
                            <label for="password" class="form-label"><i class="bi bi-person-fill-lock"></i>&ensp;Password</label>
                            <input type="password" class="form-control" id="password" name="password" placeholder="Enter password" required>
                        </div>
                        <div style="height: 10px;"></div>
                        <button type="submit" class="btn btn-primary w-100">Login</button>
                        <p class="mt-3">New to SilverCare? <i id="register-text" style="color: blue;"
                        	onclick="window.location.href='./register.jsp'"
                        >Create an account</i></p>
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
	            <strong class="me-auto" style="color: <%= notificationColor %>"><%= loginStatus %></strong>
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