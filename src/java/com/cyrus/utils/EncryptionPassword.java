/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cyrus.utils;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

/**
 *
 * @author Cyrus
 */
public class EncryptionPassword {

    public static String getSHAHash(String password) throws NoSuchAlgorithmException {
        MessageDigest md = MessageDigest.getInstance("SHA-256");
        byte[] messageDigest = md.digest(password.getBytes());
        return convertByteToHex(messageDigest);
    }

    public static String convertByteToHex(byte[] byteStream) {
        StringBuilder str = new StringBuilder();
        for (int i = 0; i < byteStream.length; i++) {
            str.append(String.format("%02x", byteStream[i]));
        }
        return str.toString();
    }
}
