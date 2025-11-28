package com.silvercare.dao;

import java.sql.*;
import java.util.*;

import com.silvercare.dto.CaregiverDto;
import com.silvercare.util.Db;
import com.silvercare.util.TimeUtil;

public class CaregiverDao {
    public static List<CaregiverDto> selectCaregiversByServiceName(String serviceName) {
        var caregiversList = new ArrayList<CaregiverDto>();

        try {
            Connection conn = Db.getConnection();
            String sqlStatement = "SELECT c.name, c.qualifications, sc.joined_on "
                    + "FROM caregiver c "
                    + "JOIN service_caregiver sc ON c.id = sc.caregiver_id "
                    + "JOIN service s ON s.id = sc.service_id "
                    + "WHERE s.name = ?";
            PreparedStatement stmt = conn.prepareStatement(sqlStatement);
            stmt.setString(1, serviceName);

            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                String name = rs.getString("name");
                String qualifications = rs.getString("qualifications");
                String joinedTime = TimeUtil.convertDate(rs.getString("joined_on"));

                caregiversList.add(new CaregiverDto(name, qualifications, joinedTime));
            }
            conn.close();
        } catch(SQLException e) {
			System.out.println("SQLException at CaregiverDao.selectCaregiversByServiceName");
	        System.out.println("SQL Error Code: " + e.getErrorCode());
	        System.out.println("SQL State: " + e.getSQLState());
	        System.out.println("SQL Message: " + e.getMessage());
        }

        return caregiversList;
    }
}
