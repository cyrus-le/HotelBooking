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
public class HotelDTO implements Serializable{
    private int hotelID;
    private String hotelName;
    private String hotelAddress;
    private String hotelImage;

    public HotelDTO() {
    }

    public HotelDTO(int hotelID, String hotelName, String hotelAddress, String hotelImage) {
        this.hotelID = hotelID;
        this.hotelName = hotelName;
        this.hotelAddress = hotelAddress;
        this.hotelImage = hotelImage;
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
     * @return the hotelName
     */
    public String getHotelName() {
        return hotelName;
    }

    /**
     * @param hotelName the hotelName to set
     */
    public void setHotelName(String hotelName) {
        this.hotelName = hotelName;
    }

    /**
     * @return the hotelAddress
     */
    public String getHotelAddress() {
        return hotelAddress;
    }

    /**
     * @param hotelAddress the hotelAddress to set
     */
    public void setHotelAddress(String hotelAddress) {
        this.hotelAddress = hotelAddress;
    }

    /**
     * @return the hotelImage
     */
    public String getHotelImage() {
        return hotelImage;
    }

    /**
     * @param hotelImage the hotelImage to set
     */
    public void setHotelImage(String hotelImage) {
        this.hotelImage = hotelImage;
    }
    
    
}
