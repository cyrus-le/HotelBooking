/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.lan.dtos;

import java.util.HashMap;
import java.util.Map;
import com.lan.dtos.BookingInformation;

/**
 *
 * @author Cyrus
 */
public class CartObject {

    private Map<BookingInformation, Integer> items;

    /**
     * @return the items
     */
    public Map<BookingInformation, Integer> getItems() {
        return items;
    }

    /**
     * @param items the items to set
     */
    public void setItems(Map<BookingInformation, Integer> items) {
        this.items = items;
    }

    public boolean isContainThisOrder(BookingInformation hotelDetails) {
        boolean isContain = false;

        if (this.items != null) {
            for (BookingInformation tempHotel : this.items.keySet()) {
                if (tempHotel.getHotelID() == hotelDetails.getHotelID()
                        && tempHotel.getRoomType() == hotelDetails.getRoomType()
                        && tempHotel.getCheckInDate().toLocalDate().equals(hotelDetails.getCheckInDate().toLocalDate())
                        && tempHotel.getCheckOutDate().toLocalDate().equals(hotelDetails.getCheckOutDate().toLocalDate())) {
                    isContain = true;
                    break;
                }
            }
        }
        return isContain;
    }
    
    public int getQuantityForItem(BookingInformation hotelDetails) {
        int quantity = 0;

        if (this.items != null) {
            for (BookingInformation tempHotel : this.items.keySet()) {
                if (tempHotel.getHotelID() == hotelDetails.getHotelID()
                        && tempHotel.getRoomType() == hotelDetails.getRoomType()
                        && tempHotel.getCheckInDate().toLocalDate().equals(hotelDetails.getCheckInDate().toLocalDate())
                        && tempHotel.getCheckOutDate().toLocalDate().equals(hotelDetails.getCheckOutDate().toLocalDate())) {
                    quantity = this.items.get(tempHotel);
                    break;
                }
            }
        }
        return quantity;
    }

    public void bookThisRoom(BookingInformation hotelDetails, int quantity) {
        if (this.items == null) {
            this.items = new HashMap<>();
        }
        BookingInformation appearedHotel = null;
        for (BookingInformation tempHotel : this.items.keySet()) {
            if (tempHotel.getHotelID() == hotelDetails.getHotelID()
                    && tempHotel.getRoomType() == hotelDetails.getRoomType()
                    && tempHotel.getCheckInDate().toLocalDate().equals(hotelDetails.getCheckInDate().toLocalDate())
                    && tempHotel.getCheckOutDate().toLocalDate().equals(hotelDetails.getCheckOutDate().toLocalDate())) {
                appearedHotel = tempHotel;
                quantity += this.items.get(tempHotel);
                break;
            }
        }

        if (appearedHotel == null) {
            appearedHotel = hotelDetails;
        }
        this.items.put(appearedHotel, quantity);
    }

    public void cancelBookingThisRoom(BookingInformation hotelDetails) {
        if (this.items != null) {
            BookingInformation appearedHotel = null;
            for (BookingInformation tempHotel : this.items.keySet()) {
                if (tempHotel.getHotelID() == hotelDetails.getHotelID()
                        && tempHotel.getRoomType() == hotelDetails.getRoomType()
                        && tempHotel.getCheckInDate().toLocalDate().equals(hotelDetails.getCheckInDate().toLocalDate())
                        && tempHotel.getCheckOutDate().toLocalDate().equals(hotelDetails.getCheckOutDate().toLocalDate())) {
                    appearedHotel = tempHotel;
                    break;
                }
            }

            if (appearedHotel == null) {
                appearedHotel = hotelDetails;
            }
            this.items.remove(appearedHotel);

            if (this.items.isEmpty()) {
                this.items = null;
            }
        }
    }

    public void updateBookingRoomQuantity(BookingInformation hotelDetails, int quantity) {
        BookingInformation appearedHotel = null;
        for (BookingInformation tempHotel : this.items.keySet()) {
            if (tempHotel.getHotelID() == hotelDetails.getHotelID()
                    && tempHotel.getRoomType() == hotelDetails.getRoomType()
                    && tempHotel.getCheckInDate().toLocalDate().equals(hotelDetails.getCheckInDate().toLocalDate())
                    && tempHotel.getCheckOutDate().toLocalDate().equals(hotelDetails.getCheckOutDate().toLocalDate())) {
                appearedHotel = tempHotel;
                break;
            }
        }

        if (appearedHotel != null) {
            this.items.put(appearedHotel, quantity);
        }
    }
}
