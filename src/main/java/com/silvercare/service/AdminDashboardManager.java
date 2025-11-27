package com.silvercare.service;

import com.silvercare.dao.AdminDashboardDao;
import com.silvercare.dto.AdminDashboardDto;

public class AdminDashboardManager {
    public static AdminDashboardDto getMainDashboardData() {
        return AdminDashboardDao.selectMainDashboardData();
    }
}
