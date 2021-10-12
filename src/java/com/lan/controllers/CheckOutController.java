/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.lan.controllers;

import com.lan.daos.CartDAO;
import com.lan.daos.HotelDAO;
import com.lan.daos.HotelDetailsDAO;
import com.lan.daos.OrderDAO;
import com.lan.daos.OrderDetailsDAO;
import java.io.IOException;
import java.sql.Date;
import java.sql.SQLException;
import java.sql.Timestamp;
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
import com.lan.dtos.OrderDTO;
import com.lan.dtos.OrderDetailsDTO;
import com.lan.utils.CreateOrderIDUtil;
import com.lan.utils.SendingEmail;
import java.util.Random;
import javax.mail.MessagingException;

/**
 *
 * @author Cyrus
 */
@WebServlet(name = "CheckOutController", urlPatterns = {"/CheckOutController"})
public class CheckOutController extends HttpServlet {

    static Logger LOGGER = Logger.getLogger(CheckOutController.class);

    private final static String SEARCH_PAGE = "search";
    private final static String ERROR_PAGE = "confirm";
    private final static String NOT_AVAILABLE = "ViewCartPage";
    private final static String VERIFY_PAGE = "verifyPage";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR_PAGE;
        try {
            HttpSession session = request.getSession();
            String userId = (String) session.getAttribute("USERID");
            if (userId != null) {
                CartObject cart = (CartObject) session.getAttribute("CART");
                if (cart != null) {
                    if (cart.getItems() != null) {
                        /*Kiểm tra những sản phẩm trong cart vẫn available*/
                        boolean isStillAvailable = true;
                        boolean[] isAvailableList = new boolean[cart.getItems().size()];
                        int index = 0;
                        for (BookingInformation bookingInfor : cart.getItems().keySet()) {
                            int hotelIdCheck = bookingInfor.getHotelID();
                            int roomTypeCheck = bookingInfor.getRoomType();
                            Date fromDateCheck = bookingInfor.getCheckInDate();
                            Date toDateCheck = bookingInfor.getCheckOutDate();
                            int quantityCheck = cart.getItems().get(bookingInfor);

                            HotelDAO hotelDao = new HotelDAO();
                            boolean isAvailable = hotelDao.roomAvailable(hotelIdCheck, roomTypeCheck, quantityCheck, toDateCheck, fromDateCheck);
                            if (!isAvailable) {
                                isAvailableList[index] = false;
                                isStillAvailable = false;
                            } else {
                                isAvailableList[index] = true;
                            }
                            index++;
                        }

                        if (isStillAvailable) {
                            String orderId = new CreateOrderIDUtil().getOrderId();
                            Timestamp bookingDateTime = new Timestamp(System.currentTimeMillis());

                            Integer discountCodeId = null;
                            String discountCodeIdStr = request.getParameter("discountCodeId");
                            if (discountCodeIdStr != null && !discountCodeIdStr.isEmpty()) {
                                discountCodeId = Integer.parseInt(discountCodeIdStr);
                            }

                            OrderDTO dto = new OrderDTO(userId, orderId, bookingDateTime, discountCodeId);
                            OrderDAO dao = new OrderDAO();
                            boolean isBooked = dao.orderBooking(dto);

                            if (isBooked) {
                                boolean bookAllSuccessful = true;
                                boolean removeFromCart = true;
                                for (BookingInformation bookingInfor : cart.getItems().keySet()) {
                                    OrderDetailsDTO detailsDTO = new OrderDetailsDTO();

                                    detailsDTO.setOrderID(orderId);
                                    detailsDTO.setHotelID(bookingInfor.getHotelID());
                                    detailsDTO.setRoomID(bookingInfor.getRoomType());
                                    detailsDTO.setFromDate(bookingInfor.getCheckInDate());
                                    detailsDTO.setToDate(bookingInfor.getCheckOutDate());
                                    detailsDTO.setQuantity(cart.getItems().get(bookingInfor));

                                    //Generate Code:
                                    Random random = new Random();
                                    int num = random.nextInt(999999);
                                    String code = String.format("%06d", num);

                                    detailsDTO.setCheckoutCode(code);

                                    HotelDetailsDAO hotelDetailsDao = new HotelDetailsDAO();
                                    int price = hotelDetailsDao.getPriceByHotelIdAndRoomType(bookingInfor.getHotelID(), bookingInfor.getRoomType());
                                    detailsDTO.setRoomPrice(price);
                                    OrderDetailsDAO orderDetailDao = new OrderDetailsDAO();
                                    boolean isInserted = orderDetailDao.insertOrderBookingDetail(detailsDTO);
                                    if (!isInserted) {
                                        bookAllSuccessful = false;
                                    } else {
                                        String email = request.getParameter("txtEmail");
                                        SendingEmail sendingEmail = new SendingEmail(email, detailsDTO.getCheckoutCode());
                                        sendingEmail.sendEmail();
                                        CartDAO cartDao = new CartDAO();
                                        boolean isRemove = cartDao.cancelBookingRoom(userId, bookingInfor);
                                        if (!isRemove) {
                                            removeFromCart = false;
                                        }
                                    }
                                }

                                if (bookAllSuccessful && removeFromCart) {
                                    url = VERIFY_PAGE;
                                    session.removeAttribute("CART");
                                    request.setAttribute("ORDERID", orderId);
                                }
                            }
                        } else {
                            url = NOT_AVAILABLE;
                            request.setAttribute("AVAIROOMLIST", isAvailableList);
                        }
                    }
                }
            }
        } catch (NumberFormatException | SQLException | MessagingException | NamingException ex) {
            LOGGER.fatal("Error CheckOutController at: " + ex.getMessage());
            ex.printStackTrace();
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
