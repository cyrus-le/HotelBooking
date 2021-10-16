/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cyrus.dtos;

/**
 *
 * @author Cyrus
 */
public class FeedbackDTO {

    private int feedbackID;
    private int point;
    private int orderDetailID;
    private String userID;
    private int hotelID;
    
    public FeedbackDTO() {
    }

    public FeedbackDTO(int feedbackID, int point, int orderDetailID, String userID) {
        this.feedbackID = feedbackID;
        this.point = point;
        this.orderDetailID = orderDetailID;
        this.userID = userID;
    }

    public FeedbackDTO(int feedbackID, int point, int orderDetailID, String userID, int hotelID) {
        this.feedbackID = feedbackID;
        this.point = point;
        this.orderDetailID = orderDetailID;
        this.userID = userID;
        this.hotelID = hotelID;
    }

    public int getHotelID() {
        return hotelID;
    }

    public void setHotelID(int hotelID) {
        this.hotelID = hotelID;
    }
    
    

    public int getFeedbackID() {
        return feedbackID;
    }

    public void setFeedbackID(int feedbackID) {
        this.feedbackID = feedbackID;
    }

    public int getPoint() {
        return point;
    }

    public void setPoint(int point) {
        this.point = point;
    }

    public int getOrderDetailID() {
        return orderDetailID;
    }

    public void setOrderDetailID(int orderDetailID) {
        this.orderDetailID = orderDetailID;
    }

    public String getUserID() {
        return userID;
    }

    public void setUserID(String userID) {
        this.userID = userID;
    }

}
