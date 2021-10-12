/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.lan.controllers;

import com.lan.daos.DiscountDAO;
import com.lan.daos.HotelDAO;
import com.lan.daos.OrderDAO;
import com.lan.daos.OrderDetailsDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;
import javax.naming.NamingException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.log4j.Logger;
import com.lan.dtos.DiscountDTO;
import com.lan.dtos.HotelDTO;
import com.lan.dtos.OrderDTO;
import com.lan.dtos.OrderDetailsDTO;
import com.lan.dtos.UserDTO;
import java.util.List;

/**
 *
 * @author Cyrus
 */
@WebServlet(name = "ShowBookingHistoryController", urlPatterns = {"/ShowBookingHistoryController"})
public class ShowBookingHistoryController extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(ShowBookingHistoryController.class);
    private static final String SHOW_ORDER_LIST_PAGE = "ShowOderListPage";
    private static final String ERROR_PAGE = "LoginPage";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        String url = ERROR_PAGE;
        try {
            HttpSession session = request.getSession();
            if (session != null) {
                UserDTO userInfor = (UserDTO) session.getAttribute("USERINFOR");

                if (userInfor != null) {
                    if (userInfor.getRole() == 2) {
                        OrderDAO dao = new OrderDAO();
                        ArrayList<OrderDTO> orderList = dao.getOrderListByUserId(userInfor.getUserID());

                        if (orderList != null) {
                            request.setAttribute("ORDERLIST", orderList);
                            OrderDetailsDAO orderDetailsDao = new OrderDetailsDAO();
                            List<OrderDetailsDTO> orderDetailsList = null;
                            List<HotelDTO> hotelInforList = new ArrayList<>();

                            int[] priceList = new int[orderList.size()];
                            int count = 0;

                            for (OrderDTO order : orderList) {
                                List<OrderDetailsDTO> tempDetailsList = orderDetailsDao.
                                        getListOfOrderDetailsByOrderId(order.getOrderID());

                                if (tempDetailsList != null) {
                                    priceList[count] = 0;
                                    for (int i = 0; i < tempDetailsList.size(); i++) {
                                        boolean isNew = true;
                                        for (int j = 0; j < hotelInforList.size(); j++) {
                                            if (tempDetailsList.get(i).getHotelID() == hotelInforList.get(j).getHotelID()) {
                                                isNew = false;
                                                break;
                                            }
                                        }
                                        if (isNew) {
                                            HotelDAO hotelDao = new HotelDAO();
                                            hotelInforList.add(hotelDao.getHotelInforById(tempDetailsList.get(i).getHotelID()));
                                        }

                                        priceList[count] += tempDetailsList.get(i).getRoomPrice() * tempDetailsList.get(i).getQuantity();
                                    }

                                    Integer discountCodeObj = order.getDiscountCodeId();
                                    if (discountCodeObj != null) {
                                        int discountCodeId = discountCodeObj;
                                        DiscountDAO discountDao = new DiscountDAO();
                                        DiscountDTO discountInfor = discountDao.getDiscountInforByCodeId(discountCodeId);
                                        if (discountInfor != null) {
                                            priceList[count] = priceList[count] - (priceList[count] * discountInfor.getDiscountPercent() / 100);
                                        }
                                    }

                                    count++;

                                    if (orderDetailsList == null) {
                                        orderDetailsList = new ArrayList<>();
                                    }
                                    orderDetailsList.addAll(tempDetailsList);
                                }
                            }

                            if (orderDetailsList != null) {
                                request.setAttribute("ORDERDETAILLIST", orderDetailsList);
                                request.setAttribute("PRICELIST", priceList);
                                request.setAttribute("HOTELINFOR", hotelInforList);
                            }
                        }
                        url = SHOW_ORDER_LIST_PAGE;
                    }
                }
            }
        } catch (NamingException | SQLException ex) {
            LOGGER.fatal("Error ShowBookingHistoryController at: " + ex.getMessage());
        } finally {
            request.getRequestDispatcher(url).forward(request, response);
            out.close();
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
