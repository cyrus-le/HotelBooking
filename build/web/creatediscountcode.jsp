<%-- 
    Document   : creatediscountcode
    Created on : Nov 5, 2020, 7:13:47 AM
    Author     : ASUS
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
        <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">

        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
        <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
        <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
        <script>
            $(function () {
                $(".datepicker").datepicker({
                    dateFormat: 'dd-mm-yy'
                });
            });
        </script>
        
        <title>Create Discount Code Page</title>
    </head>
    <body>
        <c:set var="userId" value="${sessionScope.USERID}"/>
        <c:if test="${not empty userId}">
            <c:set var="userInfor" value="${sessionScope.USERINFOR}"/>
            <c:if test="${userInfor.role == 1}">
                <p>Welcome, <font color="blue">${userInfor.name}</font></p>
                <form action="logout">
                    <input type="submit" value="Logout" />
                </form>

                <c:set var="error" value="${requestScope.ERROR}"/>
                <c:set var="msg" value="${requestScope.MSG}"/>
                <div class="container">            
                    <div class="col-md-6 col-md-offset-3">
                        <div class="row">
                            <div class="col-md-6 col-md-offset-3" style="text-align: center; display: block">
                                <h1>Create Discount Code</h1>
                            </div>
                        </div>    
                        <form class="form-horizontal" action='createDiscount' method="POST">
                            <fieldset> 
                                <div class="control-group">
                                    <!-- User ID -->
                                    <label class="control-label">Discount Code</label>
                                    <div class="controls">
                                        <input class="form-control" type="text" name="txtCodeName" value="${param.txtCodeName}" placeholder="Discount Code" maxlength="100">                                
                                        <c:if test="${not empty error.codeNameLengthError}">
                                            <font color="red">${error.codeNameLengthError}</font><br/>
                                        </c:if>
                                        <c:if test="${not empty error.duplicateCodeNameError}">
                                            <font color="red">${error.duplicateCodeNameError}</font><br/>
                                        </c:if>
                                    </div>
                                </div>

                                <div class="control-group">
                                    <!-- Password -->
                                    <label class="control-label">Discount Percent</label>
                                    <div class="controls">
                                        <input class="form-control" type="number" min="1" max="99" name="txtDiscountPercent" value="" placeholder="Discount Percent">                                        
                                        <c:if test="${not empty error.discountPercentTypeError}">
                                            <font color="red">${error.discountPercentTypeError}</font><br/>
                                        </c:if>
                                        <c:if test="${not empty error.discountPercentSizeError}">
                                            <font color="red">${error.discountPercentSizeError}</font><br/>
                                        </c:if>
                                    </div>
                                </div>
                                        
                                <div class="control-group">
                                    <!-- Expiry Date -->
                                    <label class="control-label">Expiry Date</label>
                                    <div class="controls">
                                        <input type="text" class="form-control datepicker" placeholder="Default is today" name="txtExpiryDate" value="${param.txtExpiryDate}" />                                        
                                        <c:if test="${not empty error.expiryDateIsInvalid}">
                                            <font color="red">${error.expiryDateIsInvalid}</font><br/>
                                        </c:if>
                                    </div>
                                </div>

                                <c:if test="${not empty msg}">
                                    <font color="green">${msg}</font>
                                </c:if>
                                <hr>
                                <div class="control-group">
                                    <!-- Button -->
                                    <div class="controls" style="text-align: center">
                                        <input class="btn btn-success" type="submit" value="Create Discount"/>
                                    </div>
                                </div>
                            </fieldset>
                        </form>
                    </div>
                </div>  

                <c:if test="${userInfor.role != 1}">
                    <c:redirect url="LoginPage"/>
                </c:if>
            </c:if>
        </c:if>
        <c:if test="${empty userId}">
            <c:redirect url="LoginPage"/>
        </c:if>
    </body>
</html>
