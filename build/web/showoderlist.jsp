<%-- 
    Document   : showoderlist
    Created on : Nov 2, 2020, 8:53:56 PM
    Author     : ASUS
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" type="text/css" href="//netdna.bootstrapcdn.com/font-awesome/4.0.3/css/font-awesome.min.css" />
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
        <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
        <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">

        <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
        <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
        <script>
            $(function () {
                $(".datepicker").datepicker({
                    dateFormat: 'dd-mm-yy'
                });
            });
        </script>
        <link rel="stylesheet" type="text/css" href="css/history.css">
        <title>History</title>
    </head>
    <body>
        <c:set var="userId" value="${sessionScope.USERID}"/>
        <c:if test="${not empty userId}">
            <c:set var="userInfor" value="${sessionScope.USERINFOR}"/>
            <c:if test="${userInfor.role == 2}">
                <div class="col-md-8 col-md-offset-2 search-form" style="float: none">
                    <form class="form-inline" action="searchOrder">
                        <div class="form-group" style="margin: 20px">
                            <label style="margin-right: 20px">Order ID</label>
                            <input type="text" class="form-control" name="txtSearchOrderIdValue" value="${param.txtSearchOrderIdValue}"/>
                        </div>                    
                        <div class="form-group" style="margin: 20px">
                            <label style="margin-right: 20px">Booking date  </label>
                            <input type="text" class="form-control datepicker" name="txtCheckInDate" value="${param.txtCheckInDate}" />
                        </div>
                        <button type="submit" class="btn btn-primary">Search</button>
                    </form>
                    <a href="search">Link here to search again</a>
                </div>
                <c:set var="orderList" value="${requestScope.ORDERLIST}"/>
                <c:set var="orderDetailsList" value="${requestScope.ORDERDETAILLIST}"/>
                <c:set var="priceList" value="${requestScope.PRICELIST}"/>
                <c:set var="hotelInforList" value="${requestScope.HOTELINFOR}"/>
                <c:if test="${not empty orderList}">
                    <div class="container bootdey">
                        <div class="col-md-10 col-md-offset-1">
                            <div class="panel panel-default panel-order">
                                <div class="panel-heading">
                                    <h2><strong>Order history</strong></h2>
                                </div>

                                <div class="panel-body">
                                    <c:forEach var="order" items="${orderList}" varStatus="counter">
                                        <div class="row">
                                            <div class="col-md-1"><img src="https://bootdey.com/img/Content/user_3.jpg" class="media-object img-thumbnail" /></div>
                                            <div class="col-md-11">
                                                <div class="row">
                                                    <div class="col-md-12">
                                                        <div class="pull-right">
                                                            <c:url var="undisplayLink" value="undisplayorder">
                                                                <c:param name="orderID" value="${order.orderID}"/>
                                                            </c:url>
                                                            <a href="${undisplayLink}" onclick="return confirm('Are you sure to undisplay this order?');"><span class="glyphicon glyphicon-eye-close"></span></a>
                                                        </div>
                                                            <a href="feedbackDetail?orderID=${order.orderID}"><strong>Order ID: ${order.orderID}</strong></a>
                                                        <c:forEach var="orderDetails" items="${orderDetailsList}">
                                                            <c:if test="${orderDetails.orderID == order.orderID}">
                                                                <c:forEach var="hotelInfor" items="${hotelInforList}">
                                                                    <c:if test="${hotelInfor.hotelID == orderDetails.hotelID}">
                                                                        <h4>Hotel Name Here: ${hotelInfor.hotelName}</h4>
                                                                        <h4>Hotel Address Here: ${hotelInfor.hotelAddress}</h4>
                                                                        <h4>Room Type: ${orderDetails.roomID}</h4>
                                                                        <h4>Cost: ${orderDetails.roomPrice} x Quantity: ${orderDetails.quantity} = ${orderDetails.roomPrice * orderDetails.quantity}</h4>
                                                                        <h4>From: ${orderDetails.fromDate} - To: ${orderDetails.toDate}</h4>                                                                        
                                                                    </c:if>
                                                                </c:forEach>
                                                                <hr>
                                                            </c:if>                                                        
                                                        </c:forEach>

                                                    </div>
                                                    <div class="col-md-12">
                                                        <h3>Total Price: ${priceList[counter.count - 1]}</h3>
                                                    </div>
                                                    <div class="col-md-12">Order made on: ${order.bookingDateTime}</div>
                                                </div>
                                            </div>
                                        </div> 
                                    </c:forEach>

                                </div>
                            </div>
                        </div>
                    </div>
                </c:if>
                <c:if test="${empty orderList}">
                    <h2>Order list is empty</h2>
                </c:if>           
            </c:if>
            <c:if test="${userInfor.role != 2}">
                <c:redirect url="LoginPage"/>
            </c:if>
        </c:if>
        <c:if test="${empty userId}">
            <c:redirect url="LoginPage"/>
        </c:if>
    </body>
</html>