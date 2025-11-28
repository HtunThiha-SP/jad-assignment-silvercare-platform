package com.silvercare.dao;

import java.util.*;
import java.sql.*;

import com.silvercare.dto.NewsDto;
import com.silvercare.util.Db;
import com.silvercare.util.TimeUtil;

public class NewsDao {
	public static List<NewsDto> selectAllNews() {
		var newsList = new ArrayList<NewsDto>();
		
		try {
			Connection conn = Db.getConnection();
			Statement stmt = conn.createStatement();
			String sqlQuery = "SELECT n.title, n.description, c.name AS category, c.color, n.created_on, n.author "
					+ "FROM news_post n "
					+ "JOIN news_category c ON c.id = n.category_id";
			
			ResultSet rs = stmt.executeQuery(sqlQuery);
			
			while(rs.next()) {
				String title = rs.getString("title");
				String description = rs.getString("description");
				String category = rs.getString("category");
				String author = rs.getString("author");
				String createdTime = TimeUtil.convertDate(rs.getString("created_on"));
				String color = rs.getString("color");
				
				newsList.add(new NewsDto(title, description, category, author, color, createdTime));
			}
			
			conn.close();
		} catch (SQLException e) {
			System.out.println("SQLException at NewsDao.selectAllNews");
	        System.out.println("SQL Error Code: " + e.getErrorCode());
	        System.out.println("SQL State: " + e.getSQLState());
	        System.out.println("SQL Message: " + e.getMessage());
		}
		
		return newsList;
	}
}
