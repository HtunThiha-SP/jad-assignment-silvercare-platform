package com.silvercare.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.silvercare.dao.*;
import com.silvercare.dto.*;
import java.util.*;

import java.io.IOException;

@WebServlet("/checkout")
public class CheckoutServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");

        if (userId == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        List<CartDto> cartItems = CartDao.selectCartItemsByUserId(userId);

        if (cartItems == null || cartItems.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/cart.jsp");
            return;
        }

        double total = 0;
        for (CartDto item : cartItems) {
            total += item.getPrice();
        }

        System.out.println("User " + userId + " checked out. Total: $" + total);

        CartDao.clearCartByUserId(userId);

        response.sendRedirect(request.getContextPath() + "/cart.jsp");
    }
}

