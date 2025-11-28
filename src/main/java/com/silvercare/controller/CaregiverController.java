package com.silvercare.controller;

import java.util.List;

import com.silvercare.dao.CaregiverDao;
import com.silvercare.dto.CaregiverDto;

public class CaregiverController {
    public static List<CaregiverDto> getCaregiversByServiceName(String serviceName) {
        return CaregiverDao.selectCaregiversByServiceName(serviceName);
    }
}
