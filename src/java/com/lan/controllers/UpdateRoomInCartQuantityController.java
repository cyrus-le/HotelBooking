/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.lan.controllers;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.sql.SQLException;
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
import com.lan.daos.CartDAO;

/**
 *
 * @author Cyrus
 */
@WebServlet(name = "UpdateRoomInCartQuantityController",
        urlPatterns = {"/UpdateRoomInCartQuantityController"})
public class UpdateRoomInCartQuantityController extends HttpServlet {

    private final static Logger LOGGER = Logger.getLogger(UpdateRoomInCartQuantityController.class);
    private final static String VIEW_CART = "ViewCartPage";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = VIEW_CART;

        try {
            String[] hotelIdStr = request.getParameterValues("hotelId");
            String[] roomTypeStr = request.getParameterValues("roomType");
            String[] checkInDateStr = request.getParameterValues("checkInDate");
            String[] checkOutDateStr = request.getParameterValues("checkOutDate");
            String[] txtQuantityStr = request.getParameterValues("txtQuantity");

            HttpSession session = request.getSession();
            if (session != null) {
                CartObject cart = (CartObject) session.getAttribute("CART");
                String userId = (String) session.getAttribute("USERID");

                if (cart != null && userId != null) {
                    CartDAO dao = new CartDAO();

                    for (int i = 0; i < hotelIdStr.length; i++) {
                        int hotelID = Integer.parseInt(hotelIdStr[i]);
                        int roomType = Integer.parseInt(roomTypeStr[i]);
                        Date checkInDate = Date.valueOf(checkInDateStr[i]);
                        Date checkOutDate = Date.valueOf(checkOutDateStr[i]);
                        int quantity = Integer.parseInt(txtQuantityStr[i]);

                        BookingInformation bookingInfor = new BookingInformation(hotelID,
                                roomType, checkInDate, checkOutDate);
                        cart.updateBookingRoomQuantity(bookingInfor, quantity);

                        dao.updateNumOfRoomBooked(userId, bookingInfor, quantity);
                    }
                    session.setAttribute("CART", cart);
                }
            }
        } catch (NamingException | SQLException ex) {
            LOGGER.fatal("Error UpdateRoomInCartQuantityController at: " + ex.getMessage());
        } finally {
            response.sendRedirect(url);
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
