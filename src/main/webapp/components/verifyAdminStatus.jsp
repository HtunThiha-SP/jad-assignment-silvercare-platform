<%@ page import="com.silvercare.service.UserManager" %>
<%
	Integer sessionRoleId = (Integer) session.getAttribute("roleId");

	if(sessionRoleId != null && sessionRoleId.intValue() == 2) {
	} else {
		out.print("<script>alert('Unauthorized access. Please login again.');\n"
				+ "window.location.href='../login.jsp';</script>");
        return;
	}
%>