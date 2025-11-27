package com.silvercare.service;

import com.silvercare.dao.ServiceCategoryDao;
import com.silvercare.model.ServiceCategory;

import java.util.*;

public class ServiceCategoryManager {
	public static List<ServiceCategory> getAllServiceCategories() {
		return ServiceCategoryDao.selectAllServiceCategories();
	}
}
