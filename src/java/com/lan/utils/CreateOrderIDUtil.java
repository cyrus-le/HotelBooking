/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.lan.utils;

import java.sql.SQLException;
import java.util.Random;
import javax.naming.NamingException;
import com.lan.daos.OrderDAO;

/**
 *
 * @author ASUS
 */
public class CreateOrderIDUtil {

    private String orderId = null;

    private void create() throws SQLException, NamingException {
        StringBuilder tempString;
        String alphabetNumber = "qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM0123456789";
        Random random = new Random();
        OrderDAO dao = new OrderDAO();
        do {
            tempString = new StringBuilder();
            for (int i = 0; i < 8; i++) {
                tempString.append(alphabetNumber.charAt(random.nextInt(alphabetNumber.length())));
            }
        } while (dao.isExistedOrderId(tempString.toString()));

        setOrderId(tempString.toString());
    }

    /**
     * @return the orderId
     * @throws java.sql.SQLException
     * @throws javax.naming.NamingException
     */
    public String getOrderId() throws SQLException, NamingException {
        create();
        return orderId;
    }

    /**
     * @param orderId the orderId to set
     */
    public void setOrderId(String orderId) {
        this.orderId = orderId;
    }
}
