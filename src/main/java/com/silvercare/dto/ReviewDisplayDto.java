package com.silvercare.dto;

import java.sql.Timestamp;

public record ReviewDisplayDto(
        String reviewerName,
        String serviceName,
        Integer rating,
        String comment,
        Timestamp createdOn
) {}
