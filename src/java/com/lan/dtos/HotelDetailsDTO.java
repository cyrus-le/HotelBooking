/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.lan.dtos;

import java.io.Serializable;

/**
 *
 * @author Cyrus
 */
public class HotelDetailsDTO implements Serializable {

    private int hotelID;
    private int roomType;
    private int price;
    private int quantity;
    private boolean hotelRoomStatus;

    public HotelDetailsDTO() {
    }

    public HotelDetailsDTO(int hotelID, int roomType, int price, int quantity, boolean hotelRoomStatus) {
        this.hotelID = hotelID;
        this.roomType = roomType;
        this.price = price;
        this.quantity = quantity;
        this.hotelRoomStatus = hotelRoomStatus;
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
     * @return the price
     */
    public int getPrice() {
        return price;
    }

    /**
     * @param price the price to set
     */
    public void setPrice(int price) {
        this.price = price;
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
     * @return the hotelRoomStatus
     */
    public boolean isHotelRoomStatus() {
        return hotelRoomStatus;
    }

    /**
     * @param hotelRoomStatus the hotelRoomStatus to set
     */
    public void setHotelRoomStatus(boolean hotelRoomStatus) {
        this.hotelRoomStatus = hotelRoomStatus;
    }

}
