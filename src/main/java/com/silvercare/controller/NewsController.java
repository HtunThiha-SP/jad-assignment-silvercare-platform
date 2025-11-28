package com.silvercare.controller;

import java.util.*;

import com.silvercare.dao.NewsDao;
import com.silvercare.dto.NewsDto;

public class NewsController {
	public static List<NewsDto> getAllNews() {
		return NewsDao.selectAllNews();
	}
}
