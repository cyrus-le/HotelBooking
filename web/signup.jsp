<%-- 
    Document   : signup
    Created on : Oct 20, 2020, 3:31:55 PM
    Author     : ASUS
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">

        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
        <title>Sign Up Page</title>
    </head>
    <body>

        <c:set var="errors" value="${requestScope.SIGNUP_ERROR}"/>        
        <div class="container">            
            <div class="col-md-6 col-md-offset-3">
                <div class="row">
                    <div class="col-md-6 col-md-offset-3" style="text-align: center; display: block">
                        <h1>REGISTER</h1>
                    </div>
                </div>    
                <form class="form-horizontal" action='signup' method="POST">
                    <fieldset> 
                        <div class="control-group">
                            <!-- User ID -->
                            <label class="control-label" for="email">User Id</label>
                            <div class="controls">
                                <input class="form-control" type="text" name="txtUserId" value="${param.txtUserId}" placeholder="Enter your user ID" maxlength="100">                                
                                <c:if test="${not empty errors.userIdLengthError}">
                                    <font color="red">${errors.userIdLengthError}</font>
                                </c:if>
                            </div>
                        </div>

                        <div class="control-group">
                            <!-- Password -->
                            <label class="control-label" for="password">Password</label>
                            <div class="controls">
                                <input class="form-control" type="password" name="txtPassword" value="" placeholder="Enter your password" maxlength="20">
                                <c:if test="${not empty errors.passwordLengthError}">
                                    <font color="red">${errors.passwordLengthError}</font>
                                </c:if>
                            </div>
                        </div>

                        <div class="control-group">
                            <!-- Confirm password -->
                            <label class="control-label" for="confirm">Confirm password</label>
                            <div class="controls">
                                <input class="form-control" type="password" name="txtConfirmPassword" value="" placeholder="Confirm your password" maxlength="20">
                                <c:if test="${not empty errors.passwordConfirmLengthError}">
                                    <font color="red">${errors.passwordConfirmLengthError}</font>
                                </c:if>
                                <c:if test="${not empty errors.passwordConfirmError}">
                                    <font color="red">${errors.passwordConfirmError}</font>
                                </c:if>
                            </div>
                        </div>

                        <div class="control-group">
                            <!-- Full name -->
                            <label class="control-label" for="fullname">Full name</label>
                            <div class="controls">
                                <input class="form-control" type="text" name="txtName" value="${param.txtName}" placeholder="Enter your full name" maxlength="100">
                                <c:if test="${not empty errors.userNameLengthError}">
                                    <font color="red">${errors.userNameLengthError}</font>
                                </c:if>
                            </div>
                        </div> 

                        <div class="control-group">
                            <!-- Address -->
                            <label class="control-label" for="address">Address</label>
                            <div class="controls">
                                <input class="form-control" type="text" name="txtAddress" value="${param.txtAddress}" placeholder="Enter your address" maxlength="200">
                                <c:if test="${not empty errors.addressLengthError}">
                                    <font color="red">${errors.addressLengthError}</font>
                                </c:if>
                            </div>
                        </div>

                        <div class="control-group">
                            <!-- Email -->
                            <label class="control-label"  for="email">Email</label>
                            <div class="controls">
                                <input class="form-control" type="text" name="txtEmail" value="${param.txtEmail}" placeholder="Enter your email with format something@x.y" maxlength="100">                                
                                <c:if test="${not empty errors.emailLengthError}">
                                    <font color="red">${errors.emailLengthError}</font>
                                </c:if>
                                <c:if test="${not empty errors.emailTypeError}">
                                    <font color="red">${errors.emailTypeError}</font>
                                </c:if>   
                            </div>
                        </div>

                        <div class="control-group">
                            <!-- Phone Number -->
                            <label class="control-label" for="phone">Phone Number</label>
                            <div class="controls">
                                <input class="form-control" type="text" name="txtPhone" value="${param.txtPhone}" placeholder="Enter phone number with 10 digits" maxlength="10">                                
                                <c:if test="${not empty errors.phoneTypeError}">
                                    <font color="red">${errors.phoneTypeError}</font>
                                </c:if>
                                <c:if test="${not empty errors.phoneLengthError}">
                                    <font color="red">${errors.phoneLengthError}</font>
                                </c:if>
                            </div>
                        </div>

                        <c:if test="${not empty errors.duplicateUserId}">
                            <font color="red">${errors.duplicateUserId}</font>
                        </c:if>
                        <hr>
                        <div class="control-group">
                            <!-- Button -->
                            <div class="controls" style="text-align: center">
                                <input class="btn btn-success" type="submit" value="Sign Up"/>
                            </div>
                        </div>
                    </fieldset>
                </form>

                <div class="col-xs-6 col-xs-offset-3" style="text-align: center">
                    <p>Have an account - <a href="LoginPage" id="register-form-link">Sign in</a></p>                                        
                </div>
                <div class="col-xs-6 col-xs-offset-3" style="text-align: center">
                    <p>View hotel without login - <a href="search" id="register-form-link">View</a></p>                                        
                </div>
            </div>
        </div>               
    </body>
</html>
