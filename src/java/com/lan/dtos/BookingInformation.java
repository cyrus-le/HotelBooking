/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.lan.dtos;

import java.sql.Date;

/**
 *
 * @author Cyrus
 */
public class BookingInformation {
    private int hotelID;
    private int roomType;
    private Date checkInDate;
    private Date checkOutDate;

    public BookingInformation() {
    }

    public BookingInformation(int hotelID, int roomType, Date checkInDate, Date checkOutDate) {
        this.hotelID = hotelID;
        this.roomType = roomType;
        this.checkInDate = checkInDate;
        this.checkOutDate = checkOutDate;
    }

    /**
     * @return the hotelID
     */
    public int getHotelID() {
        return hotelID;
    }

    /**
     * @param hotelID the hotelID to set
     */
    public void setHotelID(int hotelID) {
        this.hotelID = hotelID;
    }

    /**
     * @return the roomType
     */
    public int getRoomType() {
        return roomType;
    }

    /**
     * @param roomType the roomType to set
     */
    public void setRoomType(int roomType) {
        this.roomType = roomType;
    }

    /**
     * @return the checkInDate
     */
    public Date getCheckInDate() {
        return checkInDate;
    }

    /**
     * @param checkInDate the checkInDate to set
     */
    public void setCheckInDate(Date checkInDate) {
        this.checkInDate = checkInDate;
    }

    /**
     * @return the checkOutDate
     */
    public Date getCheckOutDate() {
        return checkOutDate;
    }

    /**
     * @param checkOutDate the checkOutDate to set
     */
    public void setCheckOutDate(Date checkOutDate) {
        this.checkOutDate = checkOutDate;
    }
    
    
}
