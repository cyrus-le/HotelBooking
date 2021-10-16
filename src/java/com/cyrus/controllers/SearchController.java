/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cyrus.controllers;

import com.cyrus.daos.HotelDAO;
import com.cyrus.daos.HotelDetailsDAO;
import com.cyrus.daos.RoomDAO;
import java.io.IOException;
import java.sql.Date;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import javax.naming.NamingException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.log4j.Logger;
import com.cyrus.dtos.HotelDTO;
import com.cyrus.dtos.RoomDTO;
import java.util.List;

/**
 *
 * @author Cyrus
 */
@WebServlet(name = "SearchController", urlPatterns = {"/SearchController"})
public class SearchController extends HttpServlet {

    private final static Logger LOGGER = Logger.getLogger(SearchController.class);

    private final String SEARCH_PAGE = "SearchPage";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = SEARCH_PAGE;

        try {
            String searchName = request.getParameter("txtSearchName");
            if (searchName == null) {
                searchName = "";
            }
            String searchLocation = request.getParameter("txtSearchLocation");
            if (searchLocation == null) {
                searchLocation = "";
            }
            String checkInDate = request.getParameter("txtCheckInDate");
            String checkOutDate = request.getParameter("txtCheckOutDate");

            String roomQuantityStr = request.getParameter("txtRoomQuantity");
            int roomQuantity = 1;
            if (roomQuantityStr != null && !roomQuantityStr.isEmpty()) {
                roomQuantity = Integer.parseInt(roomQuantityStr);
            }

            SimpleDateFormat formatDate = new SimpleDateFormat("dd-MM-yyyy");
            java.util.Date parsed;
            Date checkIn, checkOut;

            if (checkInDate != null && !checkInDate.isEmpty()) {
                parsed = formatDate.parse(checkInDate);
                checkIn = new Date(parsed.getTime());
            } else {
                checkIn = new Date(System.currentTimeMillis());
            }

            if (checkOutDate != null && !checkOutDate.isEmpty()) {
                parsed = formatDate.parse(checkOutDate);
                checkOut = new Date(parsed.getTime());
            } else {
                checkOut = new Date(System.currentTimeMillis());
            }

            LocalDate checkInLC = checkIn.toLocalDate();
            LocalDate checkOutLC = checkOut.toLocalDate();
            LocalDate today = LocalDate.now();
            boolean checkDateSuccess = true;

            if (checkInLC.isBefore(today) || checkOutLC.isBefore(today)) {
                checkDateSuccess = false;
                request.setAttribute("INVALIDDATE", "Checkout date and checkin date must not be before today");
            }
            if (checkInLC.isAfter(checkOutLC)) {
                checkDateSuccess = false;
                request.setAttribute("INVALIDCODATE", "Checkout date must not be before checkin date");
            }

            //Truyền dữ liệu khi search
//            prepareDataForSearching(request);
            if (checkDateSuccess) {
                /* lưu lại những loại phòng thỏa điều kiện của một khách sạn cụ thể */
                HashMap<HotelDTO, List<RoomDTO>> availableHotels = new HashMap<>();
                List<RoomDTO> roomList = new RoomDAO().getRoomList();

                HotelDAO dao = new HotelDAO();
                dao.searchHotel(searchName, searchLocation);

                //getHotelList()
                List<HotelDTO> hotelList = (ArrayList<HotelDTO>) dao.getHotelList();
                for (HotelDTO hotel : hotelList) {
                    /* danh sách các phòng thỏa điều kiện */
                    List<RoomDTO> availableRoom = null;
                    for (RoomDTO room : roomList) {
                        if (dao.roomAvailable(hotel.getHotelID(), room.getRoomID(), roomQuantity, checkIn, checkOut)) {
                            if (availableRoom == null) {
                                availableRoom = new ArrayList<>();
                            }
                            availableRoom.add(room);
                        }
                    }
                    /* nếu không có loại phòng nào thỏa điều kiện thì xóa khách sạn đó ra khỏi danh sách */
                    if (availableRoom != null) {
                        availableHotels.put(hotel, availableRoom);
                    }
                }

                int[][] priceList = null;
                if (!availableHotels.isEmpty()) {
                    int numOfAvaiHotels = availableHotels.keySet().size();
                    priceList = new int[numOfAvaiHotels][roomList.size()];
                    HotelDetailsDAO hotelDetailsDao = new HotelDetailsDAO();
                    int i = -1;
                    for (HotelDTO hotel : availableHotels.keySet()) {
                        i++;
                        List<RoomDTO> avaiRoomType = availableHotels.get(hotel);
                        for (int j = 0; j < avaiRoomType.size(); j++) {
                            for (int k = 0; k < roomList.size(); k++) {
                                if (avaiRoomType.get(j).getRoomID() == roomList.get(k).getRoomID()) {
                                    priceList[i][j] = hotelDetailsDao.getPriceByHotelIdAndRoomType(hotel.getHotelID(), avaiRoomType.get(j).getRoomID());
                                }
                            }
                        }
                    }
                }

                request.setAttribute("HOTEL_LIST", availableHotels);
                request.setAttribute("PRICE_LIST", priceList);

            }
        } catch (NamingException | ParseException | SQLException ex) {
            LOGGER.error("Error SearchController at: " + ex.getMessage());
        } finally {
            request.getRequestDispatcher(url).forward(request, response);
        }
    }

//    private void prepareDataForSearching(final HttpServletRequest request) throws NamingException, SQLException {
//        RoomDAO dao = new RoomDAO();
//        List<RoomDTO> roomList = dao.getRoomList();
//        request.setAttribute("ROOMLIST", roomList);
//    }
    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
