/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cyrus.daos;

import com.cyrus.db.MyConnection;
import java.io.Serializable;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.naming.NamingException;
import com.cyrus.dtos.DiscountDTO;

/**
 *
 * @author Cyrus
 */
public class DiscountDAO implements Serializable {

    private Connection con = null;
    private PreparedStatement stm = null;
    private ResultSet rs = null;

    private void closeConnection() throws SQLException {
        if (rs != null) {
            rs.close();
        }
        if (stm != null) {
            stm.close();
        }
        if (con != null) {
            con.close();
        }
    }

    public boolean createDiscount(String codeName, int discountPercent, Date expiryDate)
            throws NamingException, SQLException {
        boolean isCreated = false;
        try {
            con = MyConnection.getConnection();
            String query = "INSERT INTO tblDiscount VALUES (?,?,GETDATE(),?)";

            stm = con.prepareStatement(query);
            stm.setString(1, codeName);
            stm.setInt(2, discountPercent);
            stm.setDate(3, expiryDate);
            isCreated = stm.executeUpdate() > 0;
        } finally {
            closeConnection();
        }
        return isCreated;
    }

    public boolean isExistedCode(String codeName) throws NamingException, SQLException {
        boolean isExisted = false;
        try {
            con = MyConnection.getConnection();
            String query = "SELECT codeName FROM tblDiscount WHERE codeName=?";

            stm = con.prepareStatement(query);
            stm.setString(1, codeName);
            rs = stm.executeQuery();
            if (rs.next()) {
                isExisted = true;
            }
        } finally {
            closeConnection();
        }
        return isExisted;
    }

    public DiscountDTO getDiscountInforByCodeName(String codeName)
            throws NamingException, SQLException {
        DiscountDTO discountInfor = null;
        try {
            con = MyConnection.getConnection();
            String query = "SELECT codeId, discountPercent, dateCreate, expiryDate "
                    + "FROM tblDiscount WHERE codeName=?";

            stm = con.prepareStatement(query);
            stm.setString(1, codeName);
            rs = stm.executeQuery();
            if (rs.next()) {
                int codeId = rs.getInt(1);
                int discountPercent = rs.getInt(2);
                Date dateCreate = rs.getDate(3);
                Date expiryDate = rs.getDate(4);
                discountInfor = new DiscountDTO(codeId, codeName, discountPercent,
                        dateCreate, expiryDate);
            }
        } finally {
            closeConnection();
        }
        return discountInfor;
    }

    public DiscountDTO getDiscountInforByCodeId(int codeId)
            throws NamingException, SQLException {
        DiscountDTO discountInfor = null;
        try {
            con = MyConnection.getConnection();
            String query = "SELECT codeName, discountPercent, dateCreate, expiryDate "
                    + "FROM tblDiscount WHERE codeId=?";

            stm = con.prepareStatement(query);
            stm.setInt(1, codeId);
            rs = stm.executeQuery();
            if (rs.next()) {
                String codeName = rs.getString(1);
                int discountPercent = rs.getInt(2);
                Date dateCreate = rs.getDate(3);
                Date expiryDate = rs.getDate(4);
                discountInfor = new DiscountDTO(codeId, codeName, discountPercent,
                        dateCreate, expiryDate);
            }
        } finally {
            closeConnection();
        }
        return discountInfor;
    }
}
