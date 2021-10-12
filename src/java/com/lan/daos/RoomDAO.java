/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.lan.daos;

import com.lan.db.MyConnection;
import com.lan.dtos.RoomDTO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import javax.naming.NamingException;

/**
 *
 * @author Cyrus
 */
public class RoomDAO {

    private final ArrayList<RoomDTO> roomList = new ArrayList<>();
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

    public ArrayList<RoomDTO> getRoomList() throws NamingException, SQLException {
        RoomDTO dto = null;
        try {
            con = MyConnection.getConnection();
            String query = "SELECT roomId, roomName FROM tblRoom";
            stm = con.prepareStatement(query);
            rs = stm.executeQuery();
            while (rs.next()) {
                int id = rs.getInt(1);
                String name = rs.getString(2);
                dto = new RoomDTO(id, name);
                roomList.add(dto);
            }
        } finally {
            closeConnection();
        }
        return roomList;
    }
}
