package com.silvercare.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import com.silvercare.service.UserManager;

import java.io.IOException;

/**
 * Servlet implementation class VerifyLoginServlet
 */
@WebServlet("/register")
public class RegisterAccountServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RegisterAccountServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String username = request.getParameter("username");
		String email = request.getParameter("email");
		String displayName = request.getParameter("displayName");
		String password = request.getParameter("password");
		
		var registerResponse = UserManager.register(username, email, displayName, password);
		var session = request.getSession();
		
		session.setAttribute("registerSuccess", registerResponse.isSuccess());
		session.setAttribute("message", registerResponse.getMessage());

		if(registerResponse.isSuccess()) {
			session.setAttribute("userId", registerResponse.getResponseData());
			session.setAttribute("displayName", displayName);
		}
		
		response.sendRedirect(request.getContextPath() + "/register.jsp");
	}

}