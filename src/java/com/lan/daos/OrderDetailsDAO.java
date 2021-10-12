/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.lan.daos;

import com.lan.db.MyConnection;
import com.lan.dtos.OrderDetailsDTO;
import java.io.Serializable;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.ArrayList;
import javax.naming.NamingException;

import java.util.List;

/**
 *
 * @author Cyrus
 */
public class OrderDetailsDAO implements Serializable {

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

    public boolean insertOrderBookingDetail(OrderDetailsDTO dto)
            throws NamingException, SQLException {
        boolean isInserted = false;
        try {
            con = MyConnection.getConnection();
            String query = "INSERT INTO tblOrderDetails VALUES (?,?,?,?,?,?,?,?)";
            stm = con.prepareStatement(query);
            stm.setString(1, dto.getOrderID());
            stm.setDate(2, dto.getFromDate());

            /* set check out datetime in 23h59' */
            Timestamp timestamp = new Timestamp(dto.getToDate().getTime());
            LocalDateTime local = timestamp.toLocalDateTime();
            local = local.plusDays(1).minusMinutes(1);
            timestamp = Timestamp.valueOf(local);
            stm.setTimestamp(3, timestamp);

            stm.setInt(4, dto.getRoomID());
            stm.setInt(5, dto.getQuantity());
            stm.setInt(6, dto.getRoomPrice());
            stm.setInt(7, dto.getHotelID());
            stm.setString(8, dto.getCheckoutCode());

            int row = stm.executeUpdate();
            if (row > 0) {
                isInserted = true;
            }
        } finally {
            closeConnection();
        }
        return isInserted;
    }

    public boolean checkoutEmailCode(String code, String email) throws SQLException, NamingException {
        boolean check = false;
        try {
            String sql = "SELECT od.orderDetailID "
                    + "FROM tblOrderDetails od "
                    + "JOIN tblOrder o "
                    + "ON od.orderID = o.orderID "
                    + "JOIN tblUser u "
                    + "ON o.userID = u.userID "
                    + "WHERE u.userEmail = ? AND od.checkoutCode = ? "
                    + "GROUP BY od.orderDetailID";
            con = MyConnection.getConnection();
            if (con != null) {
                stm = con.prepareStatement(sql);
                stm.setString(1, email);
                stm.setString(2, code);
                rs = stm.executeQuery();
                if (rs.next()) {
                    check = true;
                }
            }
        } finally {
            closeConnection();
        }
        return check;
    }

    public OrderDetailsDTO get(String orderID) throws SQLException, NamingException {
        OrderDetailsDTO dto = null;
        try {
            con = MyConnection.getConnection();
            if (con != null) {
                String query = "SELECT orderDetailID, tblHotel.hotelID, hotelName, hotelImage, "
                        + "roomID, quantity, roomPrice, fromDate, toDate "
                        + "FROM tblOrderDetails JOIN tblHotel "
                        + "ON tblOrderDetails.hotelID = tblHotel.hotelID "
                        + "WHERE orderID = ?";
                stm = con.prepareStatement(query);
                stm.setString(1, orderID);
                rs = stm.executeQuery();
                if (rs.next()) {
                    int orderDetailID = rs.getInt("orderDetailID");
                    int hotelID = rs.getInt("hotelID");
                    String hotelName = rs.getString("hotelName");
                    String hotelImage = "img\\" + rs.getString("hotelImage");
                    int roomID = rs.getInt("roomID");
                    int quantity = rs.getInt("quantity");                  
                    int roomPrice = rs.getInt("roomPrice");
                    Date fromDate = rs.getDate("fromDate");
                    Date toDate = rs.getDate("toDate");
                    dto = new OrderDetailsDTO(orderID, orderDetailID, hotelID, fromDate, toDate, roomID, quantity, roomPrice, hotelName, hotelImage);
                }
            }
        } finally {
            closeConnection();
        }
        return dto;
    }

    public List<OrderDetailsDTO> getListOfOrderDetailsByOrderId(String orderId)
            throws NamingException, SQLException {
        List<OrderDetailsDTO> orderDetailsList = null;
        try {
            con = MyConnection.getConnection();
            String query = "SELECT orderDetailID, hotelID, roomID, quantity, roomPrice, "
                    + "fromDate, toDate "
                    + "FROM tblOrderDetails WHERE orderID=?";
            stm = con.prepareStatement(query);
            stm.setString(1, orderId);
            rs = stm.executeQuery();
            OrderDetailsDTO dto = null;
            while (rs.next()) {
                int orderDetailID = rs.getInt(1);
                int hotelID = rs.getInt(2);
                int roomID = rs.getInt(3);
                int quantity = rs.getInt(4);
                int roomPrice = rs.getInt(5);
                Date fromDate = rs.getDate(6);
                Date toDate = rs.getDate(7);

                dto = new OrderDetailsDTO(orderId, orderDetailID,
                        hotelID, fromDate, toDate, roomID, quantity, roomPrice);
                if (orderDetailsList == null) {
                    orderDetailsList = new ArrayList<>();
                }
                orderDetailsList.add(dto);
            }
        } finally {
            closeConnection();
        }
        return orderDetailsList;
    }
}
