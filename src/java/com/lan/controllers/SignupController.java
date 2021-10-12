/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.lan.controllers;

import com.lan.daos.UserDAO;
import java.io.IOException;
import java.sql.SQLException;
import com.lan.dtos.UserErrorObj;
import com.lan.utils.CheckNumberUtil;
import java.security.NoSuchAlgorithmException;
import java.util.regex.Pattern;
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
@WebServlet(name = "SignupController", urlPatterns = {"/SignupController"})
public class SignupController extends HttpServlet {

    private static final String SUCCESS = "login.jsp";
    private static final String ERRROR = "signup.jsp";
    private static final UserErrorObj errorObj = new UserErrorObj();
    private static final UserDAO dao = new UserDAO();
    private static final Logger LOGGER = Logger.getLogger(SignupController.class);

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERRROR;

        try {
            if (checkValidate(request)) {
                callRegister(request);
                url = SUCCESS;
            } else {
                request.setAttribute("SIGNUP_ERROR", errorObj);
            }

        } catch (SQLException | NamingException | NoSuchAlgorithmException ex) {
            LOGGER.error("Error SignupController at: " + ex.getMessage());
            if (ex.getMessage().contains("duplicate")) {
                errorObj.setDuplicateUserId("Already has this userId");
                request.setAttribute("SIGNUP_ERROR", errorObj);
            }
        } finally {
            request.getRequestDispatcher(url).forward(request, response);
        }

    }

    private void callRegister(final HttpServletRequest request) throws NamingException, SQLException, NoSuchAlgorithmException {
        String url = ERRROR;
        String userId = request.getParameter("txtUserId");
        String password = request.getParameter("txtPassword");
        String username = request.getParameter("txtName");
        String address = request.getParameter("txtAddress");
        String email = request.getParameter("txtEmail");
        String phone = request.getParameter("txtPhone");
        boolean check = dao.registerAccount(userId, password, username, address, email, phone);
        if (check) {
            url = SUCCESS;
        } else {
            request.setAttribute("SIGNUP_ERROR", errorObj);
        }
    }

    private boolean checkValidate(final HttpServletRequest request) {
        return validateUserID(request) && validatePassword(request) && validateConfirmPassword(request)
                && validateUsername(request) && validateAddress(request) && validateEmail(request) && validatePhone(request);
    }

    private boolean validatePhone(final HttpServletRequest request) {
        boolean check = Boolean.FALSE;
        String phone = request.getParameter("txtPhone");
        if (phone.length() != 10) {
            errorObj.setPhoneLengthError("Phone number must be 10 digits");
        } else {
            boolean isFormat = new CheckNumberUtil().check(phone);
            if (!isFormat) {
                errorObj.setPhoneTypeError("Phone number must not contain letter or special characters");
            } else {
                check = true;
            }
        }
        return check;
    }

    private boolean validateEmail(final HttpServletRequest request) {
        boolean check = Boolean.FALSE;
        String email = request.getParameter("txtEmail");
        if (email.isEmpty() || email.length() > 100) {
            errorObj.setEmailLengthError("Email must be entered or no longer than 100 chareacters");
        } else {
            boolean isValidEmail = Pattern.matches("^[A-Za-z0-9+_.]+@(.+)$", email);
            if (!isValidEmail) {
                errorObj.setEmailTypeError("Email type is wrong");
            } else {
                check = true;
            }
        }
        return check;
    }

    private boolean validateAddress(final HttpServletRequest request) {
        boolean check = Boolean.FALSE;
        String address = request.getParameter("txtAddress");
        if (address.length() < 6 || address.length() > 200) {
            errorObj.setAddressLengthError("Address must be 6..200 characters");
        } else {
            check = true;
        }
        return check;
    }

    private boolean validateUsername(final HttpServletRequest request) {
        boolean check = Boolean.FALSE;
        String username = request.getParameter("txtName");
        if (username.length() < 6 || username.length() > 100) {
            errorObj.setUserNameLengthError("Username must be 6..100 characters");
        } else {
            check = true;
        }
        return check;
    }

    private boolean validateConfirmPassword(final HttpServletRequest request) {
        boolean check = Boolean.FALSE;
        String confirmPass = request.getParameter("txtConfirmPassword");
        if (confirmPass.length() < 6 || confirmPass.length() > 20) {
            errorObj.setPasswordConfirmLengthError("Confirm password must be 6..20 characters");
        } else {
            if (!confirmPass.equals(request.getParameter("txtPassword"))) {
                errorObj.setPasswordConfirmError("Confirm password is different from password");
            } else {
                check = true;
            }
        }
        return check;
    }

    private boolean validatePassword(final HttpServletRequest request) {
        boolean check = Boolean.FALSE;
        String password = request.getParameter("txtPassword");
        if (password.length() < 6 || password.length() > 20) {
            errorObj.setPasswordLengthError("Password must be 6..20 characters");
        } else {
            check = true;
        }
        return check;
    }

    private boolean validateUserID(final HttpServletRequest request) {
        boolean check = Boolean.FALSE;
        final String userId = request.getParameter("txtUserId");
        if (userId.length() < 6 || userId.length() > 100) {
            errorObj.setUserIdLengthError("User ID must be 6..100 characters");
        } else {
            check = true;
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
