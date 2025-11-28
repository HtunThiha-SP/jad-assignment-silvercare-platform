package com.silvercare.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import com.silvercare.controller.CartController;
import com.silvercare.controller.UserController;

/**
 * Servlet implementation class AddCartItemServlet
 */
@WebServlet("/add-cart-item")
public class AddCartItemServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddCartItemServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String serviceName = request.getParameter("serviceName");
		int userId = (Integer) request.getSession().getAttribute("userId");
		
		CartController.addCartItem(serviceName, userId);
		
		response.sendRedirect(request.getContextPath() + "/cart.jsp");
	}

}
