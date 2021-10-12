<%-- 
    Document   : viewcart
    Created on : Oct 27, 2020, 8:16:05 AM
    Author     : ASUS
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>
        <script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
        <title>View Cart Page</title>
    </head>

    <body style="margin-top: 20px">
        <c:set var="userId" value="${sessionScope.USERID}"/>
        <c:if test="${not empty userId}">
            <c:set var="userInfor" value="${sessionScope.USERINFOR}"/>
            <c:if test="${userInfor.role != 2}">
                <c:redirect url="LoginPage"/>
            </c:if>

            <c:if test="${not empty userInfor.name}">
                <p>Welcome, <font color="blue">${userInfor.name}</font></p>
                <form action="logout">
                    <input type="submit" value="Logout" />
                </form>
            </c:if>
        </c:if>
        <c:if test="${empty userId}">
            <c:redirect url="LoginPage"/>
        </c:if>

        <div class="container">
            <div class="row">
                <div class="col-md-8 col-md-offset-2">
                    <div class="panel panel-info">
                        <div class="panel-heading">
                            <div class="panel-title">
                                <div class="row">
                                    <div class="col-xs-6">
                                        <h5><span class="glyphicon glyphicon-shopping-cart"></span> Booking Order</h5>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="panel-body">
                        <c:set var="cart" value="${sessionScope.CART}"/>
                        <c:if test="${not empty cart.items}">
                            <c:set var="hotelNameList" value="${requestScope.NAMELIST}"/>
                            <c:set var="hotelPriceList" value="${requestScope.PRICELIST}"/>
                            <c:set var="totalPrice" value="${requestScope.TOTALPRICE}"/>
                            <c:set var="amountAvaiRoom" value="${requestScope.AVAIROOM}"/>
                            <c:set var="avaiRooms" value="${requestScope.AVAIROOMLIST}"/>
                            <c:set var="hotelInforList" value="${requestScope.HOTELINFORLIST}"/>

                            <form action="updateRoomInCartQuantity" method="POST">
                                <c:forEach var="item" items="${cart.items}" varStatus="counter">
                                    <div class="row">
                                        <div class="col-xs-2"><img class="img-responsive" src="${hotelInforList[counter.count - 1].hotelImage}" width="100" height="70">
                                        </div>
                                        <div class="col-xs-5">
                                            <input type="hidden" name="hotelId" value="${item.key.hotelID}" />
                                            <h4 class="product-name"><strong>${hotelNameList[counter.count - 1]}</strong></h4>

                                            <input type="hidden" name="checkInDate" value="${item.key.checkInDate}" />
                                            <h4><small>From Date: ${item.key.checkInDate}</small></h4>

                                            <input type="hidden" name="checkOutDate" value="${item.key.checkOutDate}" />
                                            <h4><small>To Date: ${item.key.checkOutDate}</small></h4>

                                            <input type="hidden" name="roomType" value="${item.key.roomType}" />
                                            <h4><small>Room Type: ${item.key.roomType}</small></h4>






                                            <c:if test="${not empty avaiRooms}">
                                                <c:if test="${not avaiRooms[counter.count - 1]}">
                                                    <font color="red">There is not enough room left</font>
                                                </c:if>
                                            </c:if>                                            
                                        </div>
                                        <div class="col-xs-4">
                                            <div class="col-xs-4">
                                                <h6><strong>${hotelPriceList[counter.count - 1]} <span class="text-muted">x</span></strong></h6>
                                            </div>
                                            <div class="col-xs-4">
                                                <input type="number" class="form-control input-sm" name="txtQuantity" value="${item.value}" min="1" max="${amountAvaiRoom[counter.count - 1]}">
                                            </div>
                                            <div class="col-xs-2 text-right">
                                                <h6><strong> = ${hotelPriceList[counter.count - 1] * item.value}</strong></h6>
                                            </div>
                                            <div class="col-xs-1">
                                                <!-- <button type="button" class="btn btn-link btn-xs"> -->
                                                <c:url var="deleteLink" value="delete">
                                                    <c:param name="hotelId" value="${item.key.hotelID}"/>
                                                    <c:param name="roomType" value="${item.key.roomType}"/>
                                                    <c:param name="checkInDate" value="${item.key.checkInDate}"/>
                                                    <c:param name="checkOutDate" value="${item.key.checkOutDate}"/>
                                                </c:url>                                                
                                                <a href="${deleteLink}" onclick="return confirm('Are you sure you want to cancel booking this room?');"><span class="glyphicon glyphicon-trash"> </span></a>
                                                <!-- </button> -->
                                            </div>
                                        </div>
                                    </div>
                                    <hr>
                                </c:forEach>
                                <div class="row">
                                    <div class="text-center">
                                        <div class="col-xs-9 nav nav-pills">
                                            <c:url var="searchLink" value="search">
                                                <c:param name="txtSearchName" value="${param.txtSearchName}"/>
                                                <c:param name="txtSearchLocation" value="${param.txtSearchLocation}"/>
                                                <c:param name="txtRoomQuantity" value="${param.quantity}"/>
                                                <c:param name="txtCheckInDate" value="${param.checkInDate}"/>
                                                <c:param name="txtCheckOutDate" value="${param.checkOutDate}"/>
                                            </c:url>
                                            <a href="${searchLink}">Continue search</a>
                                        </div>

                                        <div class="col-xs-3">
                                            <input type="submit" class="btn btn-default btn-sm btn-block" value="Update order"/>
                                        </div>
                                    </div>
                                </div>
                            </form>

                        </div>
                        <div class="panel-footer">
                            <div class="row text-center">
                                <div class="col-xs-3">
                                    <h4 class="text-right">Total price: <strong>${totalPrice}</strong></h4>
                                </div>
                                <form action="confirm" method="POST">
                                    <div class="col-xs-6">
                                        <div class="input-group">
                                            <span class="input-group-addon" id="basic-addon3">Discount Code</span>
                                            <input type="text" class="form-control" id="basic-url" aria-describedby="basic-addon3" name="txtDiscountCode" value="">
                                            <c:set var="invalidCode" value="${requestScope.INVALIDCODE}"/>
                                            <c:if test="${not empty invalidCode}">
                                                <font color="red">${invalidCode}</font><br/>
                                            </c:if>
                                            <c:set var="notAvaiCode" value="${requestScope.NOTAVAICODE}"/>
                                            <c:if test="${not empty notAvaiCode}">
                                                <font color="red">${notAvaiCode}</font><br/>
                                            </c:if>                                                
                                        </div>
                                    </div>
                                    <div class="col-xs-3">
                                        <input type="submit" class="btn btn-success btn-block" value="Checkout"/>
                                    </div>
                                </form>

                            </div>
                        </div>
                    </c:if>
                    <c:if test="${empty cart.items}">
                        <a href="search">Click here to search again</a>
                    </c:if>
                </div>
            </div>
        </div>
    </body>
</html>
