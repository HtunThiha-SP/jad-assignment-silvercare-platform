package com.silvercare.dto;

public class ServiceDto {
    private String name;
    private String title;
    private String description;
    private double price;
    private int imgIndex;
    private String durationStr;
    private String createdTime;
    private String lastUpdatedTime;
    
    public ServiceDto() { }

    public ServiceDto(String name, String title, String description, double price, int imgIndex,
                      String durationStr, String createdTime, String lastUpdatedTime) {
        this.name = name;
        this.title = title;
        this.description = description;
        this.price = price;
        this.imgIndex = imgIndex;
        this.durationStr = durationStr;
        this.createdTime = createdTime;
        this.lastUpdatedTime = lastUpdatedTime;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
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

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public int getImgIndex() {
        return imgIndex;
    }

    public void setImgIndex(int imgIndex) {
        this.imgIndex = imgIndex;
    }

    public String getDurationStr() {
        return durationStr;
    }

    public void setDurationStr(String durationStr) {
        this.durationStr = durationStr;
    }

    public String getCreatedTime() {
        return createdTime;
    }

    public void setCreatedTime(String createdTime) {
        this.createdTime = createdTime;
    }

    public String getLastUpdatedTime() {
        return lastUpdatedTime;
    }

    public void setLastUpdatedTime(String lastUpdatedTime) {
        this.lastUpdatedTime = lastUpdatedTime;
    }
}