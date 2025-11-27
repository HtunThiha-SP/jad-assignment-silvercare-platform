package com.silvercare.service;


import java.util.List;

import com.silvercare.dao.ServiceDao;
import com.silvercare.dto.ServiceDto;

public class ServiceManager {
	public static List<ServiceDto> getServicesByCategoryName(String name) {
		return ServiceDao.selectServicesByCategoryName(name);
	}
}