package com.silvercare.controller;

import java.util.List;
import java.util.Map;

import com.silvercare.dao.ReviewDao;
import com.silvercare.dto.ReviewCreateDto;
import com.silvercare.dto.ReviewDisplayDto;
import com.silvercare.util.OperationResponse;

public class ReviewController {

    public static OperationResponse addReview(Integer userId,
                                              Integer serviceId,
                                              Integer rating,
                                              String comment) {

        boolean success;
        String message;
        String code;

        // basic validation
        if (userId == null) {
            success = false;
            message = "You must be logged in to submit a review.";
            code = "REVIEW_NOT_LOGGED_IN";
            return new OperationResponse(success, message, code, null);
        }

        if (serviceId == null || rating == null ||
                rating < 1 || rating > 5 ||
                comment == null || comment.isBlank()) {

            success = false;
            message = "Please provide a rating and a short comment.";
            code = "REVIEW_VALIDATION_ERROR";
            return new OperationResponse(success, message, code, null);
        }

        ReviewCreateDto data = new ReviewCreateDto(userId, serviceId, rating, comment.trim());
        OperationResponse daoResponse = ReviewDao.insertReview(data);

        if (daoResponse.isSuccess()) {
            success = true;
            message = "Thank you for your review.";
        } else {
            success = false;
            message = "Unable to submit review. Please try again.";
        }

        return new OperationResponse(success, message, daoResponse.getCode(), daoResponse.getResponseData());
    }

    public static List<ReviewDisplayDto> getReviewsForCategory(String categoryName) {
        return ReviewDao.selectReviewsByCategoryName(categoryName);
    }

    public static Map<String, Object> getReviewSummaryForCategory(String categoryName) {
        return ReviewDao.selectSummaryByCategoryName(categoryName);
    }
}
