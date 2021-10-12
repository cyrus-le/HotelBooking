/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.lan.daos;

import com.lan.dtos.FeedbackDTO;
import com.lan.db.MyConnection;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.naming.NamingException;

/**
 *
 * @author Cyrus
 */
public class FeedbackDAO {

    private Connection con;
    private PreparedStatement stm;
    private ResultSet rs;

    private void closeConnection() throws SQLException {
        if (rs != null) {
            rs.close();
        }
        if (stm != null) {
            stm.close();
        }
        if (con != null) {
            con.close();
        }
    }

    public FeedbackDTO get(int orderDetailID) throws NamingException, SQLException {
        FeedbackDTO dto = null;
        try {
            String query = "SELECT feedbackID, point, userID, hotelID FROM tblFeedback WHERE orderDetailID = ?";
            con = MyConnection.getConnection();
            if (con != null) {
                stm = con.prepareStatement(query);
                stm.setInt(1, orderDetailID);
                rs = stm.executeQuery();
                if (rs.next()) {
                    int feedbackID = rs.getInt("feedbackID");
                    int point = rs.getInt("point");               
                    String userID = rs.getString("userID");
                    int hotelID = rs.getInt("hotelID");
                    dto = new FeedbackDTO(feedbackID, point, orderDetailID, userID,hotelID);
                }
            }
        } finally {
            closeConnection();
        }
        return dto;
    }

    public boolean insert(FeedbackDTO dto)
            throws NamingException, SQLException, NoSuchAlgorithmException {
        boolean check = false;
        try {
            String sql = "INSERT INTO tblFeedback(point, orderDetailID, userID, hotelID) VALUES (?,?,?,?)";
            con = MyConnection.getConnection();
            if (con != null) {             
                stm = con.prepareStatement(sql);
                stm.setInt(1, dto.getPoint());
                stm.setInt(2, dto.getOrderDetailID());
                stm.setString(3, dto.getUserID());
                stm.setInt(4, dto.getHotelID());
                check = stm.executeUpdate() > 0;
            }

        } finally {
            closeConnection();
        }
        return check;
    }

    public boolean update(FeedbackDTO dto) throws SQLException, NamingException {
        boolean check = false;
        try {
            String query = "UPDATE tblFeedback SET point = ? WHERE feedbackID = ? AND userID = ?";
            con = MyConnection.getConnection();
            stm = con.prepareStatement(query);
            stm.setInt(1, dto.getPoint());
            stm.setInt(2, dto.getFeedbackID());
            stm.setString(3, dto.getUserID());
            check = stm.executeUpdate() > 0;

        } finally {
            closeConnection();
        }
        return check;
    }

}
