/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.lan.dtos;

import java.io.Serializable;
import java.sql.Date;

/**
 *
 * @author Cyrus
 */
public class OrderDetailsDTO implements Serializable {

    private String orderID;
    private int orderDetailID;
    private int hotelID;
    private Date fromDate;
    private Date toDate;
    private int roomID;
    private int quantity;
    private int roomPrice;
    private String checkoutCode;
    
    private String hotelName;
    private String hotelImage;

    public OrderDetailsDTO() {
    }

    public OrderDetailsDTO(String orderID, int orderDetailID, int hotelID, Date fromDate, Date toDate, int roomID, int quantity, int roomPrice, String checkoutCode) {
        this.orderID = orderID;
        this.orderDetailID = orderDetailID;
        this.hotelID = hotelID;
        this.fromDate = fromDate;
        this.toDate = toDate;
        this.roomID = roomID;
        this.quantity = quantity;
        this.roomPrice = roomPrice;
        this.checkoutCode = checkoutCode;
    }

    public OrderDetailsDTO(String orderID, int orderDetailID, int hotelID, Date fromDate, Date toDate, int roomID, int quantity, int roomPrice) {
        this.orderID = orderID;
        this.orderDetailID = orderDetailID;
        this.hotelID = hotelID;
        this.fromDate = fromDate;
        this.toDate = toDate;
        this.roomID = roomID;
        this.quantity = quantity;
        this.roomPrice = roomPrice;
    }

    public OrderDetailsDTO(String orderID, int orderDetailID, int hotelID, Date fromDate, Date toDate, int roomID, int quantity, int roomPrice, String hotelName, String hotelImage) {
        this.orderID = orderID;
        this.orderDetailID = orderDetailID;
        this.hotelID = hotelID;
        this.fromDate = fromDate;
        this.toDate = toDate;
        this.roomID = roomID;
        this.quantity = quantity;
        this.roomPrice = roomPrice;
        this.hotelName = hotelName;
        this.hotelImage = hotelImage;
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
     * @return the orderDetailID
     */
    public int getOrderDetailID() {
        return orderDetailID;
    }

    /**
     * @param orderDetailID the orderDetailID to set
     */
    public void setOrderDetailID(int orderDetailID) {
        this.orderDetailID = orderDetailID;
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
     * @return the roomID
     */
    public int getRoomID() {
        return roomID;
    }

    /**
     * @param roomID the roomID to set
     */
    public void setRoomID(int roomID) {
        this.roomID = roomID;
    }

    /**
     * @return the quantity
     */
    public int getQuantity() {
        return quantity;
    }

    /**
     * @param quantity the quantity to set
     */
    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    /**
     * @return the roomPrice
     */
    public int getRoomPrice() {
        return roomPrice;
    }

    /**
     * @param roomPrice the roomPrice to set
     */
    public void setRoomPrice(int roomPrice) {
        this.roomPrice = roomPrice;
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

    public String getCheckoutCode() {
        return checkoutCode;
    }

    public void setCheckoutCode(String checkoutCode) {
        this.checkoutCode = checkoutCode;
    }

    public String getHotelName() {
        return hotelName;
    }

    public void setHotelName(String hotelName) {
        this.hotelName = hotelName;
    }

    public String getHotelImage() {
        return hotelImage;
    }

    public void setHotelImage(String hotelImage) {
        this.hotelImage = hotelImage;
    }

    
}
