package com.silvercare.servlet;

import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import com.silvercare.controller.ReviewController;
import com.silvercare.util.OperationResponse;

@WebServlet("/create-review")
public class CreateReviewServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response) throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("userId") == null) {
            // must be logged in
            response.sendRedirect(request.getContextPath() + "/pages/login.jsp");
            return;
        }

        Integer userId = (Integer) session.getAttribute("userId");

        String categoryName = request.getParameter("categoryName");
        String serviceIdStr = request.getParameter("serviceId");
        String ratingStr = request.getParameter("rating");
        String comment = request.getParameter("comment");

        Integer serviceId = null;
        Integer rating = null;

        try {
            serviceId = Integer.parseInt(serviceIdStr);
        } catch (NumberFormatException e) {
            // ignore, will be caught by validation
        }

        try {
            rating = Integer.parseInt(ratingStr);
        } catch (NumberFormatException e) {
            // ignore, will be caught by validation
        }

        OperationResponse reviewResponse =
                ReviewController.addReview(userId, serviceId, rating, comment);

        session.setAttribute("reviewSuccess", reviewResponse.isSuccess());
        session.setAttribute("reviewMessage", reviewResponse.getMessage());

        String encodedCategory = URLEncoder.encode(categoryName, StandardCharsets.UTF_8);
        response.sendRedirect(request.getContextPath()
                + "/pages/serviceReviews.jsp?name=" + encodedCategory);
    }
}
