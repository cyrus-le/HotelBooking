/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.lan.controllers;

import com.lan.daos.FeedbackDAO;
import com.lan.daos.OrderDetailsDAO;
import com.lan.dtos.FeedbackDTO;
import com.lan.dtos.OrderDetailsDTO;
import java.io.IOException;
import java.sql.SQLException;
import javax.naming.NamingException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.log4j.Logger;

/**
 *
 * @author Cyrus
 */
@WebServlet(name = "FeedbackDetailController", urlPatterns = {"/FeedbackDetailController"})
public class FeedbackDetailController extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(FeedbackDetailController.class);
    private static final String FEEDBACK_PAGE = "FeedbackPage";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = FEEDBACK_PAGE;
        String orderID;
        try {
            orderID = request.getParameter("orderID");
           
            OrderDetailsDAO orderDetailsDao = new OrderDetailsDAO();
            FeedbackDAO feedbackDAO = new FeedbackDAO();

            OrderDetailsDTO dto = orderDetailsDao.get(orderID);
            FeedbackDTO fbDto = feedbackDAO.get(dto.getOrderDetailID());

            request.setAttribute("OrderDetailsDTO", dto);
            request.setAttribute("FeedbackDTO", fbDto);

        } catch (SQLException | NamingException e) {
            LOGGER.error("Error LoginController at: " + e.getMessage());
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
