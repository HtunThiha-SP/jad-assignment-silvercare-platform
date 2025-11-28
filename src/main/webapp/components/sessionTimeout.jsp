<%
    HttpSession s = request.getSession(false);

    if (s == null || s.getAttribute("userId") == null) {
        if (s != null) s.invalidate();
		out.print("<script>alert('Session timed out. Please login again.');\n"
				+ "window.location.href='./login.jsp';</script>");
        return;
    }
%>