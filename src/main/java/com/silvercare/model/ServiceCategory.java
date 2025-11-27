package com.silvercare.model;

public class ServiceCategory {
	private int id;
	private String name;
	private String description;
	private int imgIndex;

	public ServiceCategory(int id, String name, String description, int imgIndex) {
		this.id = id;
		this.name = name;
		this.description = description;
		this.imgIndex = imgIndex;
	}

	public ServiceCategory(String name, String description, int imgIndex) {
		this.name = name;
		this.description = description;
		this.imgIndex = imgIndex;
	}

	public int getId() {
		return id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public int getImgIndex() {
		return imgIndex;
	}

	public void setImgIndex(int imgIndex) {
		this.imgIndex = imgIndex;
	}
}
