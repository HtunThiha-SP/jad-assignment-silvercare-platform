<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.silvercare.controller.UserController" %>
<%@ page import="com.silvercare.dto.UserUpdateDto" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@ include file="./components/header-config.html" %>
<title>SilverCare | Profile</title>
</head>
<body>
    <%@ include file="./components/sessionTimeout.jsp" %>
    <jsp:include page="./components/navBar.jsp"></jsp:include>

    <%
	    HttpSession currentSession = request.getSession(false);
	
	    if (currentSession == null || currentSession.getAttribute("userId") == null) {
	        response.sendRedirect(request.getContextPath() + "/login.jsp");
	        return;
	    }
        Integer sessionUserId = (Integer) currentSession.getAttribute("userId");
        UserUpdateDto currentUser = UserController.getUserProfileInfo(sessionUserId);

        String username = currentUser.getUsername();
        String displayName = currentUser.getDisplayName();
        String email = currentUser.getEmail();
        Integer roleId = (Integer) currentSession.getAttribute("roleId");
        String roleName = "";
        if(roleId == 1) {
        	roleName = "Customer";
        } else if (roleId == 2) {
        	roleName = "Administrator";
        }
    %>
    <%
		Boolean updateSuccess = (Boolean) session.getAttribute("updateSuccess");
		String toastVisibility = "d-none";
		String notificationColor = "#1D3142";
		String notificationMessage = "";
		String updateStatus = "";
		if(updateSuccess != null) {
			String message = (String) session.getAttribute("message");
			toastVisibility = "d-block";
			if(updateSuccess) {
				notificationColor = "#077307";
				updateStatus = "Update Successful";
				notificationMessage = "<i class=\"bi bi-arrow-up-right-square-fill\"></i>&ensp;" + message;

				out.print("<script>");
				out.print("setTimeout(function() {");
				out.print("window.location.href = '" + request.getContextPath() + "/profile.jsp';");
				out.print("}, 1500);");
				out.print("</script>");
			} else {
				notificationColor = "#FF0000";
				updateStatus = "Update Failed";
				notificationMessage = "<i class=\"bi bi-exclamation-triangle-fill\"></i>&ensp;" + message;
			}
			session.removeAttribute("updateSuccess");
		}
	%>

    <div class="container mt-5 mb-5">
        <div class="row gx-5 justify-content-center">
            <div class="col-12 col-md-4 mb-4 mb-md-0">
                <div class="card p-4 shadow-sm">
                    <div class="d-flex flex-column align-items-center text-center">
                        <div style="
                            width: 80px;
                            height: 80px;
                            border-radius: 50%;
                            background-color: #E0E0E0;
                            display: flex;
                            align-items: center;
                            justify-content: center;
                            font-size: 32px;
                            font-weight: 600;
                            color: #555;">
                            <%= (displayName != null && !displayName.isEmpty())
                                    ? displayName.substring(0,1).toUpperCase()
                                    : "U" %>
                        </div>
                        <h5 class="mt-3 mb-1"><%= displayName %></h5>
                        <p class="text-muted mb-2">@<%= username %></p>
                        <p class="text-muted mb-1">
                            <i class="bi bi-envelope-at-fill"></i>&ensp;<%= email %>
                        </p>
                        <p class="text-muted mb-0" style="font-size: 14px;">
                            <i class="bi bi-person-badge-fill"></i>&ensp;
                            <%= roleName %>
                        </p>
                    </div>
                    <hr class="my-4">
                    <p class="text-muted mb-1" style="font-size: 14px;">
                        From this page, you can update your personal details and review your bookings.
                    </p>
                    <p class="text-muted mb-0" style="font-size: 13px;">
                        Keeping your information up to date helps us personalise your care and contact you when needed.
                    </p>
                </div>
            </div>

            <div class="col-12 col-md-6">
                <div class="card p-4 shadow-sm">
                    <form action="<%= request.getContextPath() %>/update-user-profile" method="post">
                        <h5 class="mb-3">
                            <i class="bi bi-info-circle-fill"></i>&ensp;Update Profile
                        </h5>

                        <div class="mb-3">
                            <label class="form-label">
                                <i class="bi bi-person-circle"></i>&ensp;Username
                            </label>
                            <input type="text"
                                   class="form-control update-profile-input-field"
                                   name="username"
                                   value="<%= username %>"
                                   required>
                        </div>

                        <div class="mb-3">
                            <label class="form-label">
                                <i class="bi bi-person-badge"></i>&ensp;Display Name
                            </label>
                            <input type="text"
                                   class="form-control update-profile-input-field"
                                   name="displayName"
                                   value="<%= displayName %>"
                                   required>
                        </div>

                        <div class="mb-3">
                            <label class="form-label">
                                <i class="bi bi-envelope-at-fill"></i>&ensp;Email
                            </label>
                            <input type="email"
                                   class="form-control update-profile-input-field"
                                   name="email"
                                   value="<%= email %>"
                                   required>
                        </div>

                        <div class="d-flex gap-2 mb-4">
                            <button type="submit"
                                    id="update-profile-button"
                                    class="btn btn-primary w-50"
                                    disabled>
                                Update Profile
                            </button>
                        </div>
                    </form>

                    <hr class="my-4">

					<form id="updatePasswordForm" action="<%= request.getContextPath() %>/update-password" method="post">
					    <h5 class="mb-3">
					        <i class="bi bi-shield-lock-fill"></i>&ensp;Change Password
					    </h5>
					
					    <div class="mb-3">
					        <label class="form-label">Current Password</label>
					        <input type="password"
					               class="form-control update-password-input-field"
					               name="currentPassword"
					               placeholder="Enter your current password"
					               required
					               pattern=".{8,}"
               					   title="Password must be at least 8 characters long">
					    </div>
					
					    <div class="mb-3">
					        <label class="form-label">New Password</label>
					        <input type="password"
					               class="form-control update-password-input-field"
					               id="newPassword"
					               name="newPassword"
					               placeholder="Enter a new password"
					               required
					          	   pattern=".{8,}"
               					   title="Password must be at least 8 characters long">
					    </div>
					
					    <div class="mb-3">
					        <label class="form-label">Confirm New Password</label>
					        <input type="password"
					               class="form-control update-password-input-field"
					               id="confirmPassword"
					               name="confirmPassword"
					               placeholder="Re-enter new password"
					               required
					               pattern=".{8,}"
               					   title="Password must be at least 8 characters long">
					    	<div id="passwordAlertText" class="text-danger mb-3" style="font-size: 13px;"></div>
					    </div>
					
					    <div class="d-flex gap-2 mb-4">
					        <button type="submit"
					                id="update-password-button"
					                class="btn btn-outline-primary w-50">
					            Update Password
					        </button>
					    </div>
					</form>
					
					<script>
					document.getElementById("updatePasswordForm").addEventListener("submit", function(e) {
					    const newPassword = document.getElementById("newPassword").value;
					    const confirmPassword = document.getElementById("confirmPassword").value;
					    const currentPassword = document.getElementById("currentPassword").value;
					
					    if (newPassword !== confirmPassword) {
					        e.preventDefault();
					        document.getElementById("passwordAlertText").innerHTML = `<i class="bi bi-exclamation-circle-fill"></i>&ensp;Passwords do not match.`;
					    }
					    
					    if (newPassword == currentPassword) {
					        e.preventDefault();
					        document.getElementById("passwordAlertText").innerHTML = `<i class="bi bi-exclamation-circle-fill"></i>&ensp;New password must be different from current password.`;
					    }
					});
					</script>

                    <hr class="my-3">

                    <!-- Logout -->
                    <form action="<%= request.getContextPath() %>/logout" method="post">
                        <button type="submit" class="btn btn-danger w-50">
                            <i class="bi bi-box-arrow-left"></i>&ensp;Logout
                        </button>
                    </form>
                </div>
            </div>
        </div>

        <div class="row justify-content-center mt-5">
            <div class="col-12 col-md-10">
                <div class="card p-4 shadow-sm">
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <h5 class="mb-0">
                            <i class="bi bi-calendar-check-fill"></i>&ensp;My Bookings
                        </h5>
                        <div class="btn-group btn-group-sm" role="group">
                            <button type="button" class="btn btn-outline-secondary active">Upcoming</button>
                            <button type="button" class="btn btn-outline-secondary">Past</button>
                        </div>
                    </div>

                    <div class="table-responsive">
                        <table class="table table-hover align-middle mb-0">
                            <thead>
                                <tr>
                                    <th>#</th>
                                    <th>Service</th>
                                    <th>Category</th>
                                    <th>Date &amp; Time</th>
                                    <th>Status</th>
                                    <th>Total (SGD)</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>1</td>
                                    <td>Personal Care Session (1 hour)</td>
                                    <td>In-home Care</td>
                                    <td>12 Dec 2025, 10:00 AM</td>
                                    <td><span class="badge bg-success">Confirmed</span></td>
                                    <td>$90.00</td>
                                </tr>
                                <tr>
                                    <td>2</td>
                                    <td>Medical Appointment Transport</td>
                                    <td>Transportation &amp; Meal Delivery</td>
                                    <td>15 Dec 2025, 2:30 PM</td>
                                    <td><span class="badge bg-warning text-dark">Pending</span></td>
                                    <td>$40.00</td>
                                </tr>
                                <tr>
                                    <td>3</td>
                                    <td>Home Exercise &amp; Mobility Session</td>
                                    <td>Lifestyle Wellness Support</td>
                                    <td>20 Dec 2025, 5:00 PM</td>
                                    <td><span class="badge bg-secondary">Completed</span></td>
                                    <td>$60.00</td>
                                </tr>
                            </tbody>
                        </table>
                    </div>

                    <p class="text-muted mt-3 mb-0" style="font-size: 13px;">
                        These are sample entries for layout preview. Once booking features are implemented,
                        this section will automatically show your real bookings.
                    </p>
                </div>
            </div>
        </div>
    </div>

    <%@ include file="../components/footer.html" %>

    <script>
        // Enable "Update Profile" button when profile fields change
        const profileInputs = document.querySelectorAll(".update-profile-input-field");
        const updateProfileBtn = document.getElementById("update-profile-button");
        profileInputs.forEach(input => {
            input.addEventListener("input", () => {
                updateProfileBtn.disabled = false;
            });
        });

        // Enable "Update Password" button when any password fields change
        const passwordInputs = document.querySelectorAll(".update-password-input-field");
        const updatePasswordBtn = document.getElementById("update-password-button");
        passwordInputs.forEach(input => {
            input.addEventListener("input", () => {
                updatePasswordBtn.disabled = false;
            });
        });
    </script>

    	<div class="position-fixed bottom-0 end-0 p-3" style="z-index: 1055;">
	    <div class="toast fade show <%= toastVisibility %>" role="alert" aria-live="assertive" aria-atomic="true">
	        <div class="toast-header">
	            <svg aria-hidden="true" class="bd-placeholder-img rounded me-2" height="20" preserveAspectRatio="xMidYMid slice" width="20" xmlns="http://www.w3.org/2000/svg">
	                <rect width="100%" height="100%" fill="<%= notificationColor %>"></rect>
	            </svg>
	            <strong class="me-auto" style="color: <%= notificationColor %>"><%= updateStatus %></strong>
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