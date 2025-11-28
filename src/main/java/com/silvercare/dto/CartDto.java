package com.silvercare.dto;

public class CartDto {
    private int id;
    private String serviceName;
    private String serviceCategory;
    private String description;
    private double price;

    public CartDto() {
    }

    public CartDto(int id, String serviceName, String serviceCategory, String description, double price) {
        this.id = id;
        this.serviceName = serviceName;
        this.serviceCategory = serviceCategory;
        this.description = description;
        this.price = price;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getServiceName() {
        return serviceName;
    }

    public void setServiceName(String serviceName) {
        this.serviceName = serviceName;
    }

    public String getServiceCategory() {
        return serviceCategory;
    }

    public void setServiceCategory(String serviceCategory) {
        this.serviceCategory = serviceCategory;
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
}