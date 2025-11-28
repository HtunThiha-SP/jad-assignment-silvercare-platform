package com.silvercare.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import com.silvercare.controller.UserController;

/**
 * Servlet implementation class UserUpdatePasswordServlet
 */
@WebServlet("/update-password")
public class UserUpdatePasswordServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UserUpdatePasswordServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String oldPassword = request.getParameter("currentPassword");
		String newPassword = request.getParameter("newPassword");
		Integer userId = (Integer) request.getSession().getAttribute("userId");
		
		var updateResponse = UserController.updateUserPassword(oldPassword, newPassword, userId);
		var session = request.getSession();
		
		session.setAttribute("updateSuccess", updateResponse.isSuccess());
		session.setAttribute("message", updateResponse.getMessage());

		response.sendRedirect(request.getContextPath() + "/profile.jsp");
	}
}