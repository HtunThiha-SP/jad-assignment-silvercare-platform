package com.silvercare.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Map;

import com.silvercare.controller.UserController;

/**
 * Servlet implementation class UserUpdateServlet
 */
@WebServlet("/update-user-profile")
public class UserUpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UserUpdateServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
    
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String username = request.getParameter("username");
		String displayName = request.getParameter("displayName");
		String email = request.getParameter("email");
		Integer userId = (Integer) request.getSession().getAttribute("userId");
		
        if (displayName == null || displayName.isEmpty()) {
            displayName = username;
        }
		
		var updateResponse = UserController.updateUserProfile(username, email, displayName, userId);
		var session = request.getSession();
		
		session.setAttribute("updateSuccess", updateResponse.isSuccess());
		session.setAttribute("message", updateResponse.getMessage());

		if(updateResponse.isSuccess()) {
			session.setAttribute("displayName", displayName);
		}

		response.sendRedirect(request.getContextPath() + "/profile.jsp");
	}

}
