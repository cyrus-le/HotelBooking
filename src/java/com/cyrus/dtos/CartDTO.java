/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cyrus.dtos;

import java.io.Serializable;
import java.sql.Date;

/**
 *
 * @author Cyrus
 */
public class CartDTO implements Serializable {

    private String userID;
    private int hotelID;
    private int roomType;
    private int cartQuantity;
    private Date fromDate;
    private Date toDate;
    private boolean itemStatus;

    public CartDTO() {
    }

    public CartDTO(String userID, int hotelID, int roomType, Date fromDate,
            Date toDate, int cartQuantity, boolean itemStatus) {
        this.userID = userID;
        this.hotelID = hotelID;
        this.roomType = roomType;
        this.cartQuantity = cartQuantity;
        this.fromDate = fromDate;
        this.toDate = toDate;
        this.itemStatus = itemStatus;
    }

    /**
     * @return the userID
     */
    public String getUserID() {
        return userID;
    }

    /**
     * @param userID the userID to set
     */
    public void setUserID(String userID) {
        this.userID = userID;
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
     * @return the cartQuantity
     */
    public int getCartQuantity() {
        return cartQuantity;
    }

    /**
     * @param cartQuantity the cartQuantity to set
     */
    public void setCartQuantity(int cartQuantity) {
        this.cartQuantity = cartQuantity;
    }

    /**
     * @return the fromDate
     */
    public Date getFromDate() {
        return fromDate;
    }

    /**
     * @param fromDate the fromDate to set
     */
    public void setFromDate(Date fromDate) {
        this.fromDate = fromDate;
    }

    /**
     * @return the toDate
     */
    public Date getToDate() {
        return toDate;
    }

    /**
     * @param toDate the toDate to set
     */
    public void setToDate(Date toDate) {
        this.toDate = toDate;
    }

    /**
     * @return the itemStatus
     */
    public boolean isItemStatus() {
        return itemStatus;
    }

    /**
     * @param itemStatus the itemStatus to set
     */
    public void setItemStatus(boolean itemStatus) {
        this.itemStatus = itemStatus;
    }

}
