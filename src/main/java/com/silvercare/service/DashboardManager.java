package com.silvercare.service;

import com.silvercare.dao.MainDashboardDao;
import com.silvercare.dto.MainDashboardDto;

public class DashboardManager {
    public static MainDashboardDto getMainDashboardData() {
        return MainDashboardDao.selectMainDashboardData();
    }
}
