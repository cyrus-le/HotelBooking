/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.lan.controllers;

import com.lan.daos.CartDAO;
import java.io.IOException;
import java.sql.Date;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import javax.naming.NamingException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.log4j.Logger;
import com.lan.dtos.BookingInformation;
import com.lan.dtos.CartObject;

/**
 *
 * @author CYRUS
 */
@WebServlet(name = "AddToCartController", urlPatterns = {"/AddToCartController"})
public class AddToCartController extends HttpServlet {

    private final static  Logger LOGGER = Logger.getLogger(AddToCartController.class);
    private final static String VIEW_CART_PAGE = "ViewCartPage";
    private final static  String SEARCH_PAGE = "search";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = "LoginPage";

        try {
            HttpSession session = request.getSession();
            String userID = (String) session.getAttribute("USERID");

            if (userID != null) {
                url = SEARCH_PAGE;

                CartObject cart = (CartObject) session.getAttribute("CART");

                if (cart == null) {
                    cart = new CartObject();
                }

                String hotelIDStr = request.getParameter("hotelID");
                String roomTypeStr = request.getParameter("roomType");
                String quantityStr = request.getParameter("quantity");
                String checkInDateStr = request.getParameter("txtCheckInDate");
                String checkOutDateStr = request.getParameter("txtcCheckOutDate");
                System.out.println(checkInDateStr);
                System.out.println(checkOutDateStr);

                int hotelID = Integer.parseInt(hotelIDStr);
                int roomType = 1;
                if (roomTypeStr != null && !roomTypeStr.isEmpty()) {
                    roomType = Integer.parseInt(roomTypeStr);
                }

                int quantity = 1;
                if (quantityStr != null && !quantityStr.isEmpty()) {
                    quantity = Integer.parseInt(quantityStr);
                }
                Date checkInDate, checkOutDate;
                SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");
                java.util.Date parsed;
                if (checkInDateStr != null && !checkInDateStr.isEmpty()) {
                    parsed = dateFormat.parse(checkInDateStr);
                    checkInDate = new Date(parsed.getTime());
                } else {
                    checkInDate = new Date(System.currentTimeMillis());
                }

                if (checkOutDateStr != null && !checkOutDateStr.isEmpty()) {
                    parsed = dateFormat.parse(checkOutDateStr);
                    checkOutDate = new Date(parsed.getTime());
                } else {
                    LocalDate local = LocalDate.now();
                    checkOutDate = Date.valueOf(local);
                }

                CartDAO dao = new CartDAO();
                boolean isUpdated = false, isBooked = false;

                BookingInformation booking = new BookingInformation(hotelID, roomType, checkInDate, checkOutDate);
                if (cart.getItems() != null) {
                    if (cart.isContainThisOrder(booking)) {
                        int tempQuantity = quantity + cart.getQuantityForItem(booking);
                        isUpdated = dao.updateNumOfRoomBooked(userID, booking, tempQuantity);
                    } else {
                        boolean orderIsChose = dao.isBookedBefore(userID, booking);
                        if (orderIsChose) {
                            isBooked = dao.reBookingRoom(userID, hotelID, roomType, checkInDate, checkOutDate, quantity);
                        } else {
                            isBooked = dao.BookingRoom(userID, hotelID, roomType, checkInDate, checkOutDate, quantity);
                        }
                    }
                } else {
                    boolean orderIsChose = dao.isBookedBefore(userID, booking);
                    if (orderIsChose) {
                        isBooked = dao.reBookingRoom(userID, hotelID, roomType, checkInDate, checkOutDate, quantity);
                    } else {
                        isBooked = dao.BookingRoom(userID, hotelID, roomType, checkInDate, checkOutDate, quantity);
                    }
                }

                if (isBooked || isUpdated) {
                    cart.bookThisRoom(booking, quantity);
                    session.setAttribute("CART", cart);
                    url = VIEW_CART_PAGE;
                }
            }
        } catch (NumberFormatException | SQLException | ParseException | NamingException e) {
            LOGGER.error("Error AddToCartController at: "+e.getMessage());
        } finally {
            request.getRequestDispatcher(url).forward(request, response);
        }
    }

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
