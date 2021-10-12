/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.lan.controllers;

import com.lan.daos.DiscountDAO;
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
import com.lan.dtos.DiscountErrorObj;

import com.lan.dtos.UserDTO;

import com.lan.utils.CheckNumberUtil;

/**
 *
 * @author Cyrus
 */
@WebServlet(name = "CreateDiscountController", urlPatterns = {"/CreateDiscountController"})
public class CreateDiscountController extends HttpServlet {

    private final static Logger LOGGER = Logger.getLogger(CreateDiscountController.class);
    private final static String CREATE_SUCCESSFUL = "CreateDiscountCodePage";
    private final static String CREATE_FAIL = "CreateDiscountCodePage";
    private final static String LOGIN_PAGE = "LoginPage";
    private final static DiscountErrorObj errorObj = new DiscountErrorObj();
    private Date exipryDate = null;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = LOGIN_PAGE;
        try {
            HttpSession session = request.getSession();
            if (session != null) {
                UserDTO userInfor = (UserDTO) session.getAttribute("USERINFOR");
                if (userInfor != null) {
                    if (userInfor.getRole() == 1) {
                        url = CREATE_FAIL;
                        if (!checkValidate(request)) {                          
                            if (checkCreateDiscount(request)) { //KT có sẵn mã discount hay chưa
                                url = CREATE_SUCCESSFUL;
                                request.setAttribute("MSG", "Create discount successful");
                            }
                        } else {
                            request.setAttribute("ERROR", errorObj);
                        }
                    }
                }
            }
        } catch (NamingException | SQLException | ParseException ex) {
            LOGGER.fatal("Error CreateDiscountController at: " + ex.getMessage());
        } finally {
            request.getRequestDispatcher(url).forward(request, response);
        }
    }

    private boolean checkCreateDiscount(final HttpServletRequest request) throws ParseException, NamingException, SQLException {
        String codeName = request.getParameter("txtCodeName");
        String discountPercentStr = request.getParameter("txtDiscountPercent");
        String expiryDateStr = request.getParameter("txtExpiryDate");
        int discountPercent = Integer.parseInt(discountPercentStr);
        exipryDate = new Date(new SimpleDateFormat("dd-MM-yyyy").parse(expiryDateStr).getTime());
        DiscountDAO dao = new DiscountDAO();
        boolean check = dao.createDiscount(codeName, discountPercent, exipryDate);
        return check;
    }

    private boolean checkValidate(final HttpServletRequest request) throws NamingException, SQLException, ParseException {
        return validateCodeName(request) && validateDiscountPercent(request) && validateExpiryDate(request);
    }

    private boolean validateExpiryDate(final HttpServletRequest request) throws ParseException {
        boolean check = Boolean.FALSE;
        String expiryDateStr = request.getParameter("txtExpiryDate");
        SimpleDateFormat formatDate = new SimpleDateFormat("dd-MM-yyyy");
        java.util.Date parsed;
        Date expiryDate;
        if (expiryDateStr != null && !expiryDateStr.isEmpty()) {
            parsed = formatDate.parse(expiryDateStr);
            expiryDate = new Date(parsed.getTime());

            LocalDate today = LocalDate.now();
            LocalDate expiryDateLC = expiryDate.toLocalDate();
            if (expiryDateLC.isBefore(today)) {
                errorObj.setExpiryDateIsInvalid("Expiry date must be today or after today");
            } else {
                check = true;
            }
        } else {
            expiryDate = new Date(System.currentTimeMillis());
            check = true;
        }
        return check;
    }

    private boolean validateDiscountPercent(final HttpServletRequest request) {
        boolean check = Boolean.FALSE;
        int discountPercent = 0;
        String discountPercentStr = request.getParameter("txtDiscountPercent");
        CheckNumberUtil checkNum = new CheckNumberUtil();
        if (!checkNum.check(discountPercentStr)) {
            errorObj.setDiscountPercentTypeError("Discount percent must be integer");
        } else {
            discountPercent = Integer.parseInt(discountPercentStr);
            if (discountPercent < 1 || discountPercent > 99) {
                errorObj.setDiscountPercentSizeError("Discount percent must be between 0..99");
            } else {
                check = true;
            }
        }
        return check;
    }

    private boolean validateCodeName(final HttpServletRequest request) throws NamingException, SQLException {
        boolean check = Boolean.FALSE;
        String codeName = request.getParameter("txtCodeName");
        if (codeName.isEmpty() || codeName.length() > 50) {
            errorObj.setCodeNameLengthError("Code name length must be 1..50 chars");
        } else {
            DiscountDAO dao = new DiscountDAO();
            if (dao.isExistedCode(codeName)) {
                errorObj.setDuplicateCodeNameError("Duplicate code");
            } else {
                check = true;
            }
        }
        return check;
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
