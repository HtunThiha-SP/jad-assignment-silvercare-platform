package com.silvercare.dao;

import java.sql.*;
import java.util.*;

import com.silvercare.dto.ReviewCreateDto;
import com.silvercare.dto.ReviewDisplayDto;
import com.silvercare.util.Db;
import com.silvercare.util.OperationResponse;

public class ReviewDao {

    public static OperationResponse insertReview(ReviewCreateDto data) {
        boolean success = false;
        String message = "";
        String code = "";
        Object responseData = null;

        String sql = """
            INSERT INTO service_review (user_id, service_id, rating, comment)
            VALUES (?, ?, ?, ?)
            """;

        try (Connection conn = Db.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            stmt.setInt(1, data.userId());
            stmt.setInt(2, data.serviceId());
            stmt.setInt(3, data.rating());
            stmt.setString(4, data.comment());

            int rows = stmt.executeUpdate();
            if (rows == 1) {
                success = true;
                code = "REVIEW_INSERT_SUCCESS";
                message = "Thank you for your feedback.";

                try (ResultSet rs = stmt.getGeneratedKeys()) {
                    if (rs.next()) {
                        responseData = rs.getInt(1); // new review id
                    }
                }
            } else {
                success = false;
                code = "REVIEW_INSERT_UNKNOWN_ERROR";
                message = "Unable to submit review. Please try again.";
            }

        } catch (SQLException e) {
            success = false;
            code = "REVIEW_INSERT_SQL_ERROR";
            message = "Database error while submitting review.";

            System.out.println("SQLException at ReviewDao.insertReview");
            System.out.println("SQL Error Code: " + e.getErrorCode());
            System.out.println("SQL State: " + e.getSQLState());
            System.out.println("SQL Message: " + e.getMessage());
        }

        return new OperationResponse(success, message, code, responseData);
    }

    public static List<ReviewDisplayDto> selectReviewsByCategoryName(String categoryName) {
        List<ReviewDisplayDto> reviews = new ArrayList<>();

        String sql = """
            SELECT u.display_name AS reviewer_name,
                   s.name AS service_name,
                   r.rating,
                   r.comment,
                   r.created_on
            FROM service_review r
            JOIN user u ON r.user_id = u.id
            JOIN service s ON r.service_id = s.id
            JOIN service_category c ON s.category_id = c.id
            WHERE c.name = ?
            ORDER BY r.created_on DESC
            """;

        try (Connection conn = Db.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, categoryName);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    reviews.add(new ReviewDisplayDto(
                            rs.getString("reviewer_name"),
                            rs.getString("service_name"),
                            rs.getInt("rating"),
                            rs.getString("comment"),
                            rs.getTimestamp("created_on")
                    ));
                }
            }

        } catch (SQLException e) {
            System.out.println("SQLException at ReviewDao.selectReviewsByCategoryName");
            System.out.println("SQL Error Code: " + e.getErrorCode());
            System.out.println("SQL State: " + e.getSQLState());
            System.out.println("SQL Message: " + e.getMessage());
        }

        return reviews;
    }

    public static Map<String, Object> selectSummaryByCategoryName(String categoryName) {
        Map<String, Object> summary = new HashMap<>();
        summary.put("avgRating", 0.0);
        summary.put("reviewCount", 0);

        String sql = """
            SELECT AVG(r.rating) AS avg_rating,
                   COUNT(*) AS review_count
            FROM service_review r
            JOIN service s ON r.service_id = s.id
            JOIN service_category c ON s.category_id = c.id
            WHERE c.name = ?
            """;

        try (Connection conn = Db.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, categoryName);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    double avg = rs.getDouble("avg_rating");
                    int count = rs.getInt("review_count");
                    summary.put("avgRating", avg);
                    summary.put("reviewCount", count);
                }
            }

        } catch (SQLException e) {
            System.out.println("SQLException at ReviewDao.selectSummaryByCategoryName");
            System.out.println("SQL Error Code: " + e.getErrorCode());
            System.out.println("SQL State: " + e.getSQLState());
            System.out.println("SQL Message: " + e.getMessage());
        }

        return summary;
    }
}
