package com.silvercare.dto;

public class NewsDto {
	private String title;
	private String description;
	private String category;
	private String author;
	private String createdTime;
	private String color;

	public NewsDto(String title, String description, String category, String author, String color, String createdTime) {
		this.title = title;
		this.description = description;
		this.category = category;
		this.author = author;
		this.createdTime = createdTime;
		this.color = color;
	}

	public String getColor() {
		return color;
	}

	public void setColor(String color) {
		this.color = color;
	}



	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public String getAuthor() {
		return author;
	}

	public void setAuthor(String author) {
		this.author = author;
	}

	public String getCreatedTime() {
		return createdTime;
	}

	public void setCreatedTime(String createdTime) {
		this.createdTime = createdTime;
	}
}
