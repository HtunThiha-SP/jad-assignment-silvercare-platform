package com.silvercare.controller;

import com.silvercare.dao.MainDashboardDao;
import com.silvercare.dto.MainDashboardDto;

public class DashboardController {
    public static MainDashboardDto getMainDashboardData() {
        return MainDashboardDao.selectMainDashboardData();
    }
}
