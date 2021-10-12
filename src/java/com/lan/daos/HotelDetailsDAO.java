/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.lan.daos;

import com.lan.db.MyConnection;
import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.naming.NamingException;


/**
 *
 * @author Cyrus
 */
public class HotelDetailsDAO implements Serializable {

    private Connection con = null;
    private PreparedStatement stm = null;
    private ResultSet rs = null;

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

    public int getPriceByHotelIdAndRoomType(int hotelID, int roomType)
            throws NamingException, SQLException {
        int price = 0;
        try {
            con = MyConnection.getConnection();
            String query = "SELECT price FROM tblHotelDetails WHERE hotelID = ? AND roomType = ?";
            stm = con.prepareCall(query);
            stm.setInt(1, hotelID);
            stm.setInt(2, roomType);
            rs = stm.executeQuery();
            if (rs.next()) {
                price = rs.getInt(1);
            }
        } finally {
            closeConnection();
        }
        return price;
    }
}
