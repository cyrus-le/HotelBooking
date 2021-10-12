/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.lan.daos;

import com.lan.db.MyConnection;
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
import com.lan.dtos.BookingInformation;
import com.lan.dtos.CartDTO;

/**
 *
 * @author yru
 */
public class CartDAO implements Serializable {

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

    private ArrayList<CartDTO> cartList = null;

    public ArrayList<CartDTO> getBookingList(String userID)
            throws NamingException, SQLException {
        try {
            con = MyConnection.getConnection();
            String query = "SELECT hotelID, roomType, fromDate, toDate, cartQuantity "
                    + "FROM tblCart WHERE userID=? AND itemStatus=?";
            stm = con.prepareStatement(query);
            stm.setString(1, userID);
            stm.setBoolean(2, true);
            rs = stm.executeQuery();
            while (rs.next()) {
                int hotelID = rs.getInt(1);
                int roomType = rs.getInt(2);
                Date fromDate = rs.getDate(3);
                Date toDate = rs.getDate(4);
                int cartQuantity = rs.getInt(5);

                CartDTO dto = new CartDTO(userID, hotelID, roomType, fromDate,
                        toDate, cartQuantity, true);
                if (this.cartList == null) {
                    this.cartList = new ArrayList<>();
                }
                this.cartList.add(dto);
            }
        } finally {
            closeConnection();
        }
        return this.cartList;
    }

    public boolean BookingRoom(String userID, int hotelID, int roomType,
            Date fromDate, Date toDate, int cartQuantity)
            throws NamingException, SQLException {
        boolean isBooked = false;
        try {
            con = MyConnection.getConnection();
            String query = "INSERT INTO tblCart VALUES (?, ?, ?, ?, ?, ?, ?)";

            stm = con.prepareStatement(query);
            stm.setString(1, userID);
            stm.setInt(2, hotelID);
            stm.setInt(3, roomType);
            stm.setDate(4, fromDate);
            /* set check out datetime in 23h59' */
            Timestamp timestamp = new Timestamp(toDate.getTime());
            LocalDateTime local = timestamp.toLocalDateTime();
            local = local.plusDays(1).minusMinutes(1);
            timestamp = Timestamp.valueOf(local);
            stm.setTimestamp(5, timestamp);

            stm.setInt(6, cartQuantity);
            stm.setBoolean(7, true);

            int result = stm.executeUpdate();
            if (result > 0) {
                isBooked = true;
            }
        } finally {
            closeConnection();
        }
        return isBooked;
    }

    public boolean reBookingRoom(String userID, int hotelID, int roomType, Date fromDate,
            Date toDate, int cartQuantity) throws NamingException, SQLException {
        boolean isReBooking = false;
        try {
            con = MyConnection.getConnection();
            String query = "UPDATE tblCart SET cartQuantity=?, itemStatus=? "
                    + "WHERE userID=? AND hotelID=? AND roomType=? AND fromDate=? AND toDate=?";

            stm = con.prepareStatement(query);
            stm.setInt(1, cartQuantity);
            stm.setBoolean(2, true);
            stm.setString(3, userID);
            stm.setInt(4, hotelID);
            stm.setInt(5, roomType);
            stm.setDate(6, fromDate);

            /* set check out datetime in 23h59' */
            Timestamp timestamp = new Timestamp(toDate.getTime());
            LocalDateTime local = timestamp.toLocalDateTime();
            local = local.plusDays(1).minusMinutes(1);
            timestamp = Timestamp.valueOf(local);
            stm.setTimestamp(7, timestamp);

            int result = stm.executeUpdate();
            if (result > 0) {
                isReBooking = true;
            }
        } finally {
            closeConnection();
        }
        return isReBooking;
    }

    public boolean updateNumOfRoomBooked(String userID, BookingInformation bookingInfor,
            int cartQuantity) throws NamingException, SQLException {
        boolean isUpdated = false;

        try {
            con = MyConnection.getConnection();
            String query = "UPDATE tblCart SET cartQuantity=? "
                    + "WHERE userID=? AND hotelID=? AND roomType=? AND fromDate=? AND toDate=?";

            stm = con.prepareStatement(query);
            stm.setInt(1, cartQuantity);
            stm.setString(2, userID);
            stm.setInt(3, bookingInfor.getHotelID());
            stm.setInt(4, bookingInfor.getRoomType());
            stm.setDate(5, bookingInfor.getCheckInDate());
            /* set check out datetime in 23h59' */
            Timestamp timestamp = new Timestamp(bookingInfor.getCheckOutDate().getTime());
            LocalDateTime local = timestamp.toLocalDateTime();
            local = local.plusDays(1).minusMinutes(1);
            timestamp = Timestamp.valueOf(local);
            stm.setTimestamp(6, timestamp);

            int result = stm.executeUpdate();
            if (result > 0) {
                isUpdated = true;
            }
        } finally {
            closeConnection();
        }
        return isUpdated;
    }

    public boolean cancelBookingRoom(String userID, BookingInformation bookingInfor)
            throws NamingException, SQLException {
        boolean isDeleted = false;

        try {
            con = MyConnection.getConnection();
            String query = "UPDATE tblCart SET itemStatus=? "
                    + "WHERE userID=? AND hotelID=? AND roomType=? AND fromDate=? AND toDate=?";

            stm = con.prepareStatement(query);
            stm.setBoolean(1, false);
            stm.setString(2, userID);
            stm.setInt(3, bookingInfor.getHotelID());
            stm.setInt(4, bookingInfor.getRoomType());
            stm.setDate(5, bookingInfor.getCheckInDate());
            /* set check out datetime in 23h59' */
            Timestamp timestamp = new Timestamp(bookingInfor.getCheckOutDate().getTime());
            LocalDateTime local = timestamp.toLocalDateTime();
            local = local.plusDays(1).minusMinutes(1);
            timestamp = Timestamp.valueOf(local);
            stm.setTimestamp(6, timestamp);

            int result = stm.executeUpdate();
            if (result > 0) {
                isDeleted = true;
            }
        } finally {
            closeConnection();
        }
        return isDeleted;
    }

    public boolean isBookedBefore(String userID, BookingInformation bookingInfor)
            throws NamingException, SQLException {
        boolean isChosen = false;

        try {
            con = MyConnection.getConnection();
            String query = "SELECT userID FROM tblCart "
                    + "WHERE userID=? AND hotelID=? AND roomType=? AND fromDate=? AND toDate=?";

            stm = con.prepareStatement(query);
            stm.setString(1, userID);
            stm.setInt(2, bookingInfor.getHotelID());
            stm.setInt(3, bookingInfor.getRoomType());
            stm.setDate(4, bookingInfor.getCheckInDate());
            /* set check out datetime in 23h59' */
            Timestamp timestamp = new Timestamp(bookingInfor.getCheckOutDate().getTime());
            LocalDateTime local = timestamp.toLocalDateTime();
            local = local.plusDays(1).minusMinutes(1);
            timestamp = Timestamp.valueOf(local);
            stm.setTimestamp(5, timestamp);

            rs = stm.executeQuery();
            if (rs.next()) {
                isChosen = true;
            }
        } finally {
            closeConnection();
        }
        return isChosen;
    }
}
