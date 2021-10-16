/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cyrus.daos;

import com.cyrus.db.MyConnection;
import com.cyrus.dtos.OrderDTO;
import java.io.Serializable;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import javax.naming.NamingException;

/**
 *
 * @author Cyrus
 */
public class OrderDAO implements Serializable {

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

    public boolean isExistedOrderId(String orderId) throws NamingException, SQLException {
        boolean isExisted = false;
        try {
            con = MyConnection.getConnection();
            String query = "SELECT orderID FROM tblOrder "
                    + "WHERE orderID=?";
            stm = con.prepareStatement(query);
            stm.setString(1, orderId);
            rs = stm.executeQuery();
            if (rs.next()) {
                isExisted = true;
            }
        } finally {
            closeConnection();
        }
        return isExisted;
    }

    public boolean orderBooking(OrderDTO dto) throws NamingException, SQLException {
        boolean isOrdered = false;
        try {
            con = MyConnection.getConnection();
            String query = "INSERT INTO tblOrder VALUES (?,?,?,?,?)";
            stm = con.prepareStatement(query);

            stm.setString(1, dto.getUserID());
            stm.setString(2, dto.getOrderID());
            stm.setBoolean(3, true);
            stm.setTimestamp(4, dto.getBookingDateTime());
            if (dto.getDiscountCodeId() != null) {
                stm.setInt(5, dto.getDiscountCodeId());
            } else {
                stm.setNull(5, java.sql.Types.INTEGER);
            }

            int row = stm.executeUpdate();
            if (row > 0) {
                isOrdered = true;
            }
        } finally {
            closeConnection();
        }
        return isOrdered;
    }

    public ArrayList<OrderDTO> getOrderListByUserId(String userID)
            throws NamingException, SQLException {
        ArrayList<OrderDTO> orderList = null;
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;

        try {
            con = MyConnection.getConnection();
            String query = "SELECT orderID, bookingDateTime, discountCodeId FROM tblOrder "
                    + "WHERE userID=? AND orderStatus=? ORDER BY bookingDateTime DESC";
            stm = con.prepareStatement(query);

            stm.setString(1, userID);
            stm.setBoolean(2, true);
            rs = stm.executeQuery();

            while (rs.next()) {
                String orderID = rs.getString(1);
                Timestamp bookingDateTime = rs.getTimestamp(2);
                Integer discountCodeId = rs.getInt(3);

                OrderDTO dto = new OrderDTO(userID, orderID, bookingDateTime,
                        discountCodeId);
                if (orderList == null) {
                    orderList = new ArrayList<>();
                }
                orderList.add(dto);
            }
        } finally {
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
        return orderList;
    }

    public boolean undisplayThisOrder(String userID, String orderID)
            throws NamingException, SQLException {
        boolean isUndisplay = false;
        try {
            con = MyConnection.getConnection();
            String query = "UPDATE tblOrder SET orderStatus=? WHERE userID=? AND orderID=?";
            stm = con.prepareStatement(query);
            stm.setBoolean(1, false);
            stm.setString(2, userID);
            stm.setString(3, orderID);
            int row = stm.executeUpdate();
            if (row > 0) {
                isUndisplay = true;
            }
        } finally {
            closeConnection();
        }
        return isUndisplay;
    }

    public ArrayList<OrderDTO> searchOrderList(String userID, String searchOrderId,
            Date bookingDate) throws NamingException, SQLException {
        ArrayList<OrderDTO> orderList = null;
        OrderDTO dto = null;
        try {
            con = MyConnection.getConnection();
            String query = "SELECT orderID, bookingDateTime, discountCodeId FROM tblOrder "
                    + "WHERE userID=? AND orderID LIKE ? AND orderStatus=?";
            if (bookingDate != null) {
                query += " AND CAST(bookingDateTime AS date)=?";
            }
            query += " ORDER BY bookingDateTime DESC";

            stm = con.prepareStatement(query);
            stm.setString(1, userID);
            stm.setString(2, "%" + searchOrderId + "%");
            stm.setBoolean(3, true);
            if (bookingDate != null) {
                stm.setDate(4, bookingDate);
            }
            rs = stm.executeQuery();
            while (rs.next()) {
                String orderID = rs.getString(1);
                Timestamp bookingDateTime = rs.getTimestamp(2);
                Integer discountCodeId = rs.getInt(3);
                if (orderList == null) {
                    orderList = new ArrayList<>();
                }
                dto = new OrderDTO(userID, orderID, bookingDateTime, discountCodeId);
                orderList.add(dto);
            }
        } finally {
            closeConnection();
        }
        return orderList;
    }
}
