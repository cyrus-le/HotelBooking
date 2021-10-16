/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.cyrus.controllers;

import com.cyrus.daos.FeedbackDAO;
import com.cyrus.dtos.FeedbackDTO;
import java.io.IOException;
import java.security.NoSuchAlgorithmException;
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
@WebServlet(name = "FeedbackController", urlPatterns = {"/FeedbackController"})
public class FeedbackController extends HttpServlet {

    private final static Logger LOGGER = Logger.getLogger(FeedbackController.class);
    private final static String FEEDBACK_DETAIL = "feedbackDetail";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try {
            int point = Integer.parseInt(request.getParameter("cboFeedback"));
            String orderID = request.getParameter("orderID");
            int orderDetailID = Integer.parseInt(request.getParameter("txtOrderDetailID"));
            String userID = request.getParameter("txtUserID");
            FeedbackDAO dao = new FeedbackDAO();
            FeedbackDTO dto = new FeedbackDTO();
            int hotelID = Integer.parseInt(request.getParameter("txtHotelID"));
            dto.setHotelID(hotelID);
            dto.setOrderDetailID(orderDetailID);
            dto.setUserID(userID);
            dto.setPoint(point);
            dao.insert(dto);

        

        } catch (NumberFormatException | NoSuchAlgorithmException | SQLException | NamingException e) {
            LOGGER.fatal("Error FeedbackController at: " + e.getMessage());
        } finally {
            request.getRequestDispatcher(FEEDBACK_DETAIL).forward(request, response);
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
