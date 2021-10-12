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
import java.time.format.DateTimeParseException;
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
@WebServlet(name = "DeleteFromCartController", urlPatterns = {"/DeleteFromCartController"})
public class DeleteFromCartController extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(DeleteFromCartController.class);
    private static final String VIEW_CART = "ViewCartPage";
    private static final String SEARCH_PAGE = "search";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        String url = VIEW_CART;

        try {
            HttpSession session = request.getSession();
            String userId = (String) session.getAttribute("USERID");
            if (userId != null) {
                CartObject cart = (CartObject) session.getAttribute("CART");
                if (cart != null) {
                    if (cart.getItems() != null) {
                        String hotelIdStr = request.getParameter("hotelId");
                        String roomTypeStr = request.getParameter("roomType");
                        String checkInDateStr = request.getParameter("checkInDate");
                        String checkOutDateStr = request.getParameter("checkOutDate");

                        int hotelId = Integer.parseInt(hotelIdStr);
                        int roomType = Integer.parseInt(roomTypeStr);
                        Date checkInDate = Date.valueOf(checkInDateStr);
                        Date checkOutDate = Date.valueOf(checkOutDateStr);
                        BookingInformation bookingInfor = new BookingInformation(hotelId,
                                roomType, checkInDate, checkOutDate);

                        CartDAO dao = new CartDAO();
                        boolean isDeleted = dao.cancelBookingRoom(userId, bookingInfor);
                        if (isDeleted) {
                            cart.cancelBookingThisRoom(bookingInfor);
                        }
                        session.setAttribute("CART", cart);
                    }
                }
            } else {
                url = SEARCH_PAGE;
            }
        } catch (NamingException | SQLException | NullPointerException | NumberFormatException | DateTimeParseException ex) {
            LOGGER.fatal("Error DeleteFromCartController at: " + ex.getMessage());
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
