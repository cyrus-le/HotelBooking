/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cyrus.daos;

import com.cyrus.db.MyConnection;
import com.cyrus.dtos.HotelDTO;
import java.io.Serializable;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import javax.naming.NamingException;

import java.util.List;

/**
 *
 * @author Cyrus
 */
public class HotelDAO implements Serializable {

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
    private final List<HotelDTO> hotelList = new ArrayList<>();

    public List<HotelDTO> getHotelList() {
        return hotelList;
    }

    public void searchHotel(String searchName, String searchLocation)
            throws NamingException, SQLException {
        try {
            con = MyConnection.getConnection();
            String query = "SELECT hotelID, hotelName, hotelAddress, hotelImage "
                    + "FROM tblHotel "
                    + "WHERE hotelName LIKE '%" + searchName + "%' "
                    + "AND hotelAddress LIKE '%" + searchLocation + "%'";

            stm = con.prepareStatement(query);
            rs = stm.executeQuery();
            while (rs.next()) {
                int hotelId = rs.getInt(1);
                String hotelName = rs.getString(2);
                String hotelAddress = rs.getString(3);
                String hotelImage = "img\\" + rs.getString(4);

                HotelDTO hotel = new HotelDTO(hotelId, hotelName, hotelAddress, hotelImage);
                this.hotelList.add(hotel);
            }
        } finally {
            closeConnection();
        }
    }

    public int getAvailableAmountOfSpecificRoom(int hotelId, int roomType, Date checkInDate,
            Date checkOutDate) throws SQLException, NamingException {
        int amount = -1;
        PreparedStatement stm1 = null;
        ResultSet rs1 = null;

        try {
            con = MyConnection.getConnection();
            String query = "SELECT quantity FROM tblHotelDetails "
                    + "WHERE roomType = ? AND hotelID = ?";

            stm = con.prepareStatement(query);
            stm.setInt(1, roomType);
            stm.setInt(2, hotelId);
            rs = stm.executeQuery();
            if (rs.next()) {
                int roomQuantity = rs.getInt(1);

                ArrayList<LocalDate> dateList = new ArrayList<>();
                for (LocalDate date = checkInDate.toLocalDate();
                        date.isBefore(checkOutDate.toLocalDate()); date = date.plusDays(1)) {
                    dateList.add(date);
                }
                dateList.add(checkOutDate.toLocalDate());

                for (LocalDate local : dateList) {
                    Date temp = Date.valueOf(local);
                    String bookedRoomQuery = "SELECT SUM(quantity) FROM tblOrderDetails "
                            + "INNER JOIN tblOrder ON tblOrder.orderID = tblOrderDetails.orderID "
                            + "WHERE hotelID = ? AND roomID = ? "
                            + "AND ? BETWEEN fromDate AND toDate";

                    stm1 = con.prepareStatement(bookedRoomQuery);
                    stm1.setInt(1, hotelId);
                    stm1.setInt(2, roomType);
                    stm1.setDate(3, temp);
                    rs1 = stm1.executeQuery();
                    if (rs1.next()) {
                        int bookedQuantity = rs1.getInt(1);
                        int tempAmount = roomQuantity - bookedQuantity;

                        if (amount == -1 || amount > tempAmount) {
                            amount = tempAmount;
                        }
                    }
                }
            }
        } finally {
            if (rs1 != null) {
                rs1.close();
            }
            if (stm1 != null) {
                stm1.close();
            }
            closeConnection();
        }
        return amount;
    }

    public boolean roomAvailable(int hotelId, int roomType, int quantity, Date checkInDate,
            Date checkOutDate) throws NamingException, SQLException {
        boolean isAvailable = false;
        PreparedStatement stm1 = null;
        ResultSet rs1 = null;

        try {
            con = MyConnection.getConnection();
            String query = "SELECT quantity FROM tblHotelDetails "
                    + "WHERE roomType = ? AND hotelID = ?";

            stm = con.prepareStatement(query);
            stm.setInt(1, roomType);
            stm.setInt(2, hotelId);
            rs = stm.executeQuery();
            if (rs.next()) {
                isAvailable = true;
                int roomQuantity = rs.getInt(1);

                ArrayList<LocalDate> dateList = new ArrayList<>();
                for (LocalDate date = checkInDate.toLocalDate();
                        date.isBefore(checkOutDate.toLocalDate()); date = date.plusDays(1)) {
                    dateList.add(date);
                }
                dateList.add(checkOutDate.toLocalDate());

                for (LocalDate local : dateList) {
                    Date temp = Date.valueOf(local);
                    String bookedRoomQuery = "SELECT SUM(quantity) FROM tblOrderDetails "
                            + "INNER JOIN tblOrder ON tblOrder.orderID = tblOrderDetails.orderID "
                            + "WHERE hotelID = ? AND roomID = ? "
                            + "AND ? BETWEEN fromDate AND toDate";

                    stm1 = con.prepareStatement(bookedRoomQuery);
                    stm1.setInt(1, hotelId);
                    stm1.setInt(2, roomType);
                    stm1.setDate(3, temp);
                    rs1 = stm1.executeQuery();
                    if (rs1.next()) {
                        int bookedQuantity = rs1.getInt(1);
                        if (roomQuantity - bookedQuantity - quantity < 0) {
                            isAvailable = false;
                        }
                    }
                }
            }
        } finally {
            if (rs1 != null) {
                rs1.close();
            }
            if (stm1 != null) {
                stm1.close();
            }
            closeConnection();
        }
        return isAvailable;
    }

    public String getHotelNameById(int hotelId) throws NamingException, SQLException {
        String name = null;
        try {
            con = MyConnection.getConnection();
            String query = "SELECT hotelName FROM tblHotel WHERE hotelID = ?";
            stm = con.prepareStatement(query);
            stm.setInt(1, hotelId);
            rs = stm.executeQuery();
            if (rs.next()) {
                name = rs.getString(1);
            }
        } finally {
            closeConnection();
        }
        return name;
    }

    public HotelDTO getHotelInforById(int hotelId) throws NamingException, SQLException {
        HotelDTO hotelInfor = null;

        try {
            con = MyConnection.getConnection();
            String query = "SELECT hotelName, hotelAddress, hotelImage FROM tblHotel "
                    + "WHERE hotelID = ?";
            stm = con.prepareStatement(query);
            stm.setInt(1, hotelId);
            rs = stm.executeQuery();
            if (rs.next()) {
                String name = rs.getString(1);
                String address = rs.getString(2);
                String hotelImage = "img\\" + rs.getString(3);
                hotelInfor = new HotelDTO(hotelId, name, address, hotelImage);
            }
        } finally {
            closeConnection();
        }
        return hotelInfor;
    }
}
