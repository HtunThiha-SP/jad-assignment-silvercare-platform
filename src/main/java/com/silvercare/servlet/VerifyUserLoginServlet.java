package com.silvercare.servlet;

import java.util.*;

import com.silvercare.controller.UserController;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

/**
 * Servlet implementation class VerifyUserLoginServlet
 */
@WebServlet("/verify-user")
public class VerifyUserLoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public VerifyUserLoginServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	@SuppressWarnings("unchecked")
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		
		var loginResponse = UserController.loginUser(username, password);
		var session = request.getSession();
		
		session.setAttribute("loginSuccess", loginResponse.isSuccess());
		session.setAttribute("message", loginResponse.getMessage());
		
		int roleId = (Integer) ((Map<String, Object>) loginResponse.getResponseData()).get("roleId");

		if(loginResponse.isSuccess()) {
			session.setAttribute("userId", ((Map<String, Object>) loginResponse.getResponseData()).get("userId"));
			session.setAttribute("displayName", ((Map<String, Object>) loginResponse.getResponseData()).get("displayName"));
			session.setAttribute("roleId", roleId);
		}
		
		if(roleId == 2) {
			response.sendRedirect(request.getContextPath() + "/admin/dashboard.jsp");
			return;
		}
		response.sendRedirect(request.getContextPath() + "/login.jsp");
	}

}