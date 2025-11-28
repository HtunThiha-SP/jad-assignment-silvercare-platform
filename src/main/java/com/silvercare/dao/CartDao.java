package com.silvercare.dao;

import com.silvercare.dto.CartDto;
import com.silvercare.util.Db;

import java.util.*;
import java.sql.*;

public class CartDao {

    public static List<CartDto> selectCartItemsByUserId(int userId) {
        List<CartDto> cartItemsList = new ArrayList<>();

        try {
            Connection conn = Db.getConnection();
            String sqlQuery = "SELECT s.id AS service_id, s.name AS service_name, s.title AS description, "
                    + "s.price, sc.name AS service_category "
                    + "FROM service s "
                    + "JOIN service_category sc ON s.category_id = sc.id "
                    + "JOIN cart_item c ON c.service_id = s.id "
                    + "WHERE c.user_id = ?";
            
            PreparedStatement pstmt = conn.prepareStatement(sqlQuery);
            pstmt.setInt(1, userId);

            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                int id = rs.getInt("service_id");
                String serviceName = rs.getString("service_name");
                String serviceCategory = rs.getString("service_category");
                String description = rs.getString("description");
                double price = rs.getDouble("price");

                cartItemsList.add(new CartDto(id, serviceName, serviceCategory, description, price));
            }

            conn.close();
        } catch (SQLException e) {
            System.out.println("SQLException at CartDao.selectCartItemsByUserId");
            System.out.println("SQL Error Code: " + e.getErrorCode());
            System.out.println("SQL State: " + e.getSQLState());
            System.out.println("SQL Message: " + e.getMessage());
        }

        return cartItemsList;
    }
    
    public static void insertCartItem(String serviceName, int userId) {
        try {
            Connection conn = Db.getConnection();

            String getServiceIdQuery = "SELECT id FROM service WHERE name = ?";
            PreparedStatement pstmt1 = conn.prepareStatement(getServiceIdQuery);
            pstmt1.setString(1, serviceName);
            ResultSet rs = pstmt1.executeQuery();

            if (rs.next()) {
                int serviceId = rs.getInt("id");

                String insertQuery = "INSERT INTO cart_item(user_id, service_id) VALUES (?, ?)";
                PreparedStatement pstmt2 = conn.prepareStatement(insertQuery);
                pstmt2.setInt(1, userId);
                pstmt2.setInt(2, serviceId);
                pstmt2.executeUpdate();
            } else {
                System.out.println("Service not found: " + serviceName);
            }

            conn.close();
        } catch (SQLException e) {
            System.out.println("SQLException at CartDao.insertCartItem");
            System.out.println("SQL Error Code: " + e.getErrorCode());
            System.out.println("SQL State: " + e.getSQLState());
            System.out.println("SQL Message: " + e.getMessage());
        }
    }
    
    public static void clearCartByUserId(int userId) {
        try {
            Connection conn = Db.getConnection();
            String selectCart = "SELECT service_id FROM cart_item WHERE user_id = ?";
            PreparedStatement pstmtSelect = conn.prepareStatement(selectCart);
            pstmtSelect.setInt(1, userId);
            ResultSet rs = pstmtSelect.executeQuery();

            String insertBooking = "INSERT INTO booking(user_id, service_id, caregiver_id, appointment_on, status) "
                                 + "VALUES (?, ?, ?, ?, ?)";
            PreparedStatement pstmtBooking = conn.prepareStatement(insertBooking);

            java.sql.Timestamp appointmentTime = new java.sql.Timestamp(System.currentTimeMillis() + 2L * 24 * 60 * 60 * 1000);

            while (rs.next()) {
                int serviceId = rs.getInt("service_id");
                pstmtBooking.setInt(1, userId);
                pstmtBooking.setInt(2, serviceId);
                pstmtBooking.setInt(3, 3);
                pstmtBooking.setTimestamp(4, appointmentTime);
                pstmtBooking.setString(5, "pending");
                pstmtBooking.executeUpdate();
            }

            String deleteCart = "DELETE FROM cart_item WHERE user_id = ?";
            PreparedStatement pstmtDelete = conn.prepareStatement(deleteCart);
            pstmtDelete.setInt(1, userId);
            pstmtDelete.executeUpdate();

            conn.close();
        } catch (SQLException e) {
            System.out.println("SQLException at CartDao.clearCartByUserId");
            System.out.println("SQL Error Code: " + e.getErrorCode());
            System.out.println("SQL State: " + e.getSQLState());
            System.out.println("SQL Message: " + e.getMessage());
        }
    }


}
