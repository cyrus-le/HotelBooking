/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.lan.controllers;

import java.io.IOException;
import java.sql.SQLException;
import javax.naming.NamingException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.log4j.Logger;
import com.lan.daos.OrderDAO;

/**
 *
 * @author Cyrus
 */
@WebServlet(name = "UndisplayOrderController", urlPatterns = {"/UndisplayOrderController"})
public class UndisplayOrderController extends HttpServlet {

    private final static Logger LOGGER = Logger.getLogger(UndisplayOrderController.class);
    private final static String SHOW_ORDER_LIST_PAGE = "showorder";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");        
        String url = SHOW_ORDER_LIST_PAGE;

        try {
            HttpSession session = request.getSession();

            if (session != null) {
                String userID = (String) session.getAttribute("USERID");

                if (userID != null) {
                    String orderID = request.getParameter("orderID");

                    if (orderID != null && !orderID.isEmpty()) {
                        OrderDAO dao = new OrderDAO();
                        boolean isUndisplay = dao.undisplayThisOrder(userID, orderID);

                        if (!isUndisplay) {
                            request.setAttribute("ERROR", "Can not delete this order");
                        }
                    }
                }
            }
        } catch (NamingException | SQLException ex) {
            LOGGER.fatal("Error UndisplayOrderController at: " + ex.getMessage());
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
