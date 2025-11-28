package com.silvercare.controller;

import com.silvercare.dao.ServiceCategoryDao;
import com.silvercare.model.ServiceCategory;

import java.util.*;

public class ServiceCategoryController {
	public static List<ServiceCategory> getAllServiceCategories() {
		return ServiceCategoryDao.selectAllServiceCategories();
	}
}
