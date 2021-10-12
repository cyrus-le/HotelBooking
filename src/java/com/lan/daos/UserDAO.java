/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.lan.daos;

import com.lan.db.MyConnection;
import com.lan.dtos.UserDTO;
import com.lan.utils.EncryptionPassword;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.naming.NamingException;

/**
 *
 * @author Cyrus
 */
public class UserDAO {

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

    private UserDTO userInfor = new UserDTO();

    /**
     * @return the userInfor
     */
    public UserDTO getUserInfor() {
        return userInfor;
    }

    public boolean checkLogin(String userId, String password)
            throws NamingException, SQLException {
        boolean isCorrect = false;
        try {
            con = MyConnection.getConnection();
            String query = "SELECT userID FROM tblUser "
                    + "WHERE userID=? AND userPassword=? AND userStatus=?";

            stm = con.prepareStatement(query);
            stm.setString(1, userId);
            stm.setString(2, password);
            stm.setBoolean(3, true);

            rs = stm.executeQuery();
            if (rs.next()) {
                isCorrect = true;
                this.userInfor = getUser(userId);
            }
        } finally {
            closeConnection();
        }
        return isCorrect;
    }

    public UserDTO getUser(String userId) throws NamingException, SQLException {
        UserDTO user = null;
        try {
            con = MyConnection.getConnection();
            String query = "SELECT username, userAddress, userEmail, "
                    + "userCreateDate, userPhoneNumber, roleID "
                    + "FROM tblUser "
                    + "WHERE userID=?";

            stm = con.prepareStatement(query);
            stm.setString(1, userId);

            rs = stm.executeQuery();
            if (rs.next()) {
                String username = rs.getString(1);
                String userAddress = rs.getString(2);
                String userMail = rs.getString(3);
                Date userCreateDate = rs.getDate(4);
                String userPhoneNumber = rs.getString(5);
                int userRole = rs.getInt(6);

                user = new UserDTO(userId, username, userAddress, userMail,
                        userPhoneNumber, userCreateDate, userRole, true);
            }
        } finally {
            closeConnection();
        }
        return user;
    }

    public boolean registerAccount(String userId, String password, String userName,
            String address, String email, String phoneNumber)
            throws NamingException, SQLException, NoSuchAlgorithmException {
        boolean isRegistered = false;

        try {
            String encyptedPassword = EncryptionPassword.getSHAHash(password);
            con = MyConnection.getConnection();
            String query = "INSERT INTO tblUser VALUES (?,?,?,?,?,?,GETDATE(),?,?)";
            stm = con.prepareStatement(query);
            stm.setInt(1, 2);
            stm.setString(2, userId);
            stm.setString(3, encyptedPassword);
            stm.setString(4, userName);
            stm.setString(5, address);
            stm.setString(6, email);
            stm.setBoolean(7, true);
            stm.setString(8, phoneNumber);

            int result = stm.executeUpdate();
            if (result > 0) {
                isRegistered = true;
            }
        } finally {
            closeConnection();
        }
        return isRegistered;
    }
}
