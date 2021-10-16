/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cyrus.utils;

/**
 *
 * @author ASUS
 */
public class CheckNumberUtil {

    public boolean check(String num) {
        boolean isTrue = true;
        if (num == null || num.length() == 0) {
            return false;
        }
        for (int i = 0; i < num.length(); i++) {
            if (num.charAt(i) < '0' || num.charAt(i) > '9') {
                isTrue = false;
                break;
            }
        }
        return isTrue;
    }
}
