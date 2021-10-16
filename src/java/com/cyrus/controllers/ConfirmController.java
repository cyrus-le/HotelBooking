/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cyrus.controllers;

import com.cyrus.daos.DiscountDAO;
import com.cyrus.daos.HotelDAO;
import com.cyrus.daos.HotelDetailsDAO;
import java.io.IOException;
import java.sql.SQLException;
import java.time.LocalDate;
import javax.naming.NamingException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.log4j.Logger;
import com.cyrus.dtos.BookingInformation;
import com.cyrus.dtos.CartObject;
import com.cyrus.dtos.DiscountDTO;

/**
 *
 * @author Cyrus
 */
@WebServlet(name = "ConfirmController", urlPatterns = {"/ConfirmController"})
public class ConfirmController extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(ConfirmController.class);
    private static final String CONFIRM_PAGE = "ConfirmPage";
    private static final String VIEW_CART_PAGE = "ViewCartPage";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = VIEW_CART_PAGE;

        try {
            HttpServletRequest req = (HttpServletRequest) request;
            HttpSession session = req.getSession();
            if (session != null) {
                boolean errorFound = false;

                String discountCode = request.getParameter("txtDiscountCode");
                if (discountCode != null && !discountCode.isEmpty()) {
                    DiscountDAO discountDao = new DiscountDAO();
                    DiscountDTO discountInfor = discountDao.getDiscountInforByCodeName(discountCode);
                    if (discountInfor == null) {
                        errorFound = true;
                        request.setAttribute("INVALIDCODE", "Discount code is invalid");
                    } else {
                        LocalDate today = LocalDate.now();
                        LocalDate expiryDate = discountInfor.getExpiryDate().toLocalDate();
                        if (today.isAfter(expiryDate)) {
                            errorFound = true;
                            request.setAttribute("NOTAVAICODE", "Coupon code has expired, please choose another code");
                        } else {
                            request.setAttribute("DISCOUNTINFOR", discountInfor);
                        }
                    }
                }

                if (!errorFound) {
                    CartObject cart = (CartObject) session.getAttribute("CART");
                    if (cart != null) {
                        if (cart.getItems() != null) {
                            String[] hotelNameList = new String[cart.getItems().size()];
                            int[] priceList = new int[cart.getItems().size()];
                            HotelDAO hotelDao = new HotelDAO();
                            HotelDetailsDAO hotelDetailsDao = new HotelDetailsDAO();
                            int index = 0;
                            int totalPrice = 0;
                            for (BookingInformation item : cart.getItems().keySet()) {
                                hotelNameList[index] = hotelDao.getHotelNameById(item.getHotelID());
                                priceList[index] = hotelDetailsDao.getPriceByHotelIdAndRoomType(item.getHotelID(), item.getRoomType());
                                totalPrice += priceList[index] * cart.getItems().get(item);
                                index++;
                            }

                            url = CONFIRM_PAGE;
                            request.setAttribute("TOTALPRICE", totalPrice);
                            request.setAttribute("NAMELIST", hotelNameList);
                            request.setAttribute("PRICELIST", priceList);
                        }
                    }
                }
            }
        } catch (NamingException | SQLException ex) {
            LOGGER.fatal("Error ConfirmController at: " + ex.getMessage());
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
