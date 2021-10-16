/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cyrus.dtos;

import java.io.Serializable;
import java.sql.Timestamp;

/**
 *
 * @author Cyrus
 */
public class OrderDTO implements Serializable{
    private String userID;
    private String orderID;
    private Timestamp bookingDateTime;
    private Integer discountCodeId;

    public OrderDTO(String userID, String orderID, Timestamp bookingDateTime, Integer discountCodeId) {
        this.userID = userID;
        this.orderID = orderID;
        this.bookingDateTime = bookingDateTime;
        this.discountCodeId = discountCodeId;
    }

    public OrderDTO() {
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
     * @return the orderID
     */
    public String getOrderID() {
        return orderID;
    }

    /**
     * @param orderID the orderID to set
     */
    public void setOrderID(String orderID) {
        this.orderID = orderID;
    }

    /**
     * @return the bookingDateTime
     */
    public Timestamp getBookingDateTime() {
        return bookingDateTime;
    }

    /**
     * @param bookingDateTime the bookingDateTime to set
     */
    public void setBookingDateTime(Timestamp bookingDateTime) {
        this.bookingDateTime = bookingDateTime;
    }

    /**
     * @return the discountCodeId
     */
    public Integer getDiscountCodeId() {
        return discountCodeId;
    }

    /**
     * @param discountCodeId the discountCodeId to set
     */
    public void setDiscountCodeId(Integer discountCodeId) {
        this.discountCodeId = discountCodeId;
    }
}
