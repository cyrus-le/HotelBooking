<%-- 
    Document   : search
    Created on : Oct 20, 2020, 3:19:02 PM
    Author     : ASUS
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
        <link href="css/header.css" rel="stylesheet">
        <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">

        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>
        <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
        <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
        <script>
            $(function () {
                $(".datepicker").datepicker({
                    dateFormat: 'dd-mm-yy'
                });
            });
        </script>
        <title>Search Page</title>
    </head>

    <body>
        <c:set var="userId" value="${sessionScope.USERID}"/>
        <c:set var="userInfor" value="${sessionScope.USERINFOR}"/>          

        <header>
            <div class="container-fluid" >
                <div class="navbar-header">
                    <div>Hotel Booking</div>
                </div>
                <div>
                    <ul class="nav navbar-nav navbar-right">
                        <li>
                            <c:set var="orderId" value="${requestScope.ORDERID}"/>
                            <c:if test="${not empty orderId}">
                                <a><span class="glyphicon glyphicon-shopping-cart"></span> ${orderId}</a>
                            </c:if>
                        </li>

                        <li>
                            <c:if test="${userInfor.role == 2}">
                                <a href="ViewCartPage" ><span class="glyphicon glyphicon-shopping-cart"></span> View Cart</a>
                            </c:if>                            
                        </li>

                        <li>
                            <c:if test="${userInfor.role == 2}">
                                <a href="showorder" ><span class="glyphicon glyphicon-list-alt"></span>History</a>
                            </c:if>                            
                        </li>

                        <li>
                            <c:if test="${userInfor.role == 1}">
                                <a href="CreateDiscountCodePage" ><span class="glyphicon glyphicon-tags"></span> Create Discount</a>
                            </c:if>                            
                        </li>

                        <li>
                            <c:if test="${not empty userInfor.name}">
                                <a><span class="glyphicon glyphicon-user"></span> ${userInfor.name}</a>
                            </c:if>
                        </li>

                        <li>
                            <c:if test="${empty userId}">
                                <a href="LoginPage"><span class="glyphicon glyphicon-log-in"></span> Login</a>
                            </c:if>
                        </li>

                        <li>
                            <c:if test="${not empty userId}">
                                <a href="logout"><span class="glyphicon glyphicon-log-in"></span> Logout</a>
                            </c:if>
                        </li>
                    </ul>
                </div>
            </div>

        </header>

        <div class="container" style="top: 60px; position: relative;">
            <div class="row">
                <div class="col-md-8 col-md-offset-2">
                    <form action="search">
                        <div class="panel panel-default">
                            <div class="pane">
                                <div class="panel-body">
                                    <section class="post-heading">
                                        <h2>Search</h2>
                                    </section>
                                    <section class="post-body"> 
                                        <div class="col-md-6" style="float: left;">
                                            <input type="text" class="form-control" name="txtSearchName" placeholder="Hotel Name" value="${param.txtSearchName}"/><br/>
                                        </div>
                                        <div class="col-md-6" style="float: right;">
                                            <input type="text" class="form-control" name="txtSearchLocation" placeholder="Hotel Address" value="${param.txtSearchLocation}"/><br/>
                                        </div>
                                        <div class="col-md-4" style="float: left;">
                                            <input type="number" class="form-control" name="txtRoomQuantity" placeholder="Quantity" value="${param.txtRoomQuantity}" min="1"/><br/>
                                        </div>
                                        <div class="col-md-4" style="float: left;">
                                            <input type="text" class="form-control datepicker" name="txtCheckInDate" placeholder="Checkin date" value="${param.txtCheckInDate}"/><br/>
                                            <c:set var="invalidDate" value="${requestScope.INVALIDDATE}"/>
                                            <c:if test="${not empty invalidDate}">
                                                <font color="red">${invalidDate}</font>
                                            </c:if>
                                        </div>
                                        <div class="col-md-4" style="float: left;">
                                            <input type="text" class="form-control datepicker" name="txtCheckOutDate" placeholder="Checkout date" value="${param.txtCheckOutDate}"/><br/>
                                            <c:set var="invalidDate" value="${requestScope.INVALIDCODATE}"/>
                                            <c:if test="${not empty invalidDate}">
                                                <font color="red">${invalidDate}</font>
                                            </c:if>
                                        </div>
                                    </section>
                                    <section class="post-footer">
                                        <input class="btn btn-success form-control btn" type="submit" value="Search"/>
                                    </section>
                                </div>
                            </div> 
                        </div>  
                    </form>
                    <hr>

                    <c:set var="hotelList" value="${requestScope.HOTEL_LIST}"/>
                    <c:set var="priceList" value="${requestScope.PRICE_LIST}"/>
                    <c:if test="${not empty hotelList}">
                        <c:forEach var="hotel" items="${hotelList}" varStatus="counter">
                            <form action="addToCart" method="POST">
                                <div class="panel panel-default" style="padding-top: 20px">
                                    <div class="panel-body">
                                        <section class="post-heading">
                                            <div class="row">
                                                <div class="col-md-11">
                                                    <div class="media">                                                        
                                                        <div class="media-body">
                                                            <h3 class="media-heading">${hotel.key.hotelName}</h3>                                                             
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>             
                                        </section>
                                        <section class="post-body">
                                            <div class="row">
                                                <div class="col-md-4">
                                                    <img src="${hotel.key.hotelImage}" width="100%">
                                                </div>
                                                <div class="col-md-8">
                                                    <p>${hotel.key.hotelAddress}</p>
                                                    <%---                     <c:if test="${not empty sessionScope.USERINFOR}">

                                                        <select name="cboFeedback">
                                                            <input type="hidden" value="${sessionScope.USERINFOR.userID}" name="txtUserID"/>
                                                            <input type="hidden" value="${hotelList.hotelID}" name="txtHotelID" />
                                                            <c:forEach  begin="1" end="10" varStatus="counter">

                                                                <option value="${counter.count}">${counter.count}</option>

                                                            </c:forEach>


                                                        </select>

                                                        <br/>
                                                        <input class="btn btn-success" type="submit" value="Feedback" />
                                                        Feedback: <font color="red" >5</font>/10


                                                    </c:if>

                                                    --%>

                                                </div>
                                            </div>

                                        </section>
                                        <section class="post-footer">
                                            <hr>
                                            <div class="row">
                                                <div class="col-md-6">                                                    
                                                    <c:set var="avaiRoomList" value="${hotel.value}" />
                                                    <select name="roomType" class="form-control">                                    
                                                        <c:forEach var="room" items="${avaiRoomList}" varStatus="roomCount">
                                                            <option label="${room.roomName} - Price: ${priceList[counter.count - 1][roomCount.count - 1]}">${room.roomID}</option>                                        
                                                        </c:forEach>            
                                                    </select> 
                                                </div>
                                                <div class="col-md-6">
                                                    <c:if test="${not empty userInfor}">
                                                        <c:if test="${userInfor.role == 2}">
                                                            <input type="hidden" name="hotelID" value="${hotel.key.hotelID}" />
                                                            <input type="hidden" name="txtSearchName" value="${param.txtSearchName}" />
                                                            <input type="hidden" name="txtSearchLocation" value="${param.txtSearchLocation}" />
                                                            <input type="hidden" name="quantity" value="${param.txtRoomQuantity}" />
                                                            <input type="hidden" name="checkInDate" value="${param.txtCheckInDate}" />
                                                            <input type="hidden" name="checkOutDate" value="${param.txtCheckOutDate}" />
                                                            <input type="submit" class="btn btn-primary btn-block" value="Add To Cart"/>
                                                        </c:if>
                                                    </c:if>
                                                </div>
                                            </div>
                                        </section>
                                    </div>
                                </div> 
                            </form>
                        </c:forEach>
                    </c:if>

      
                    <c:if test="${empty hotelList}">
                        <h2>Couldn't find the right hotel for your request</h2>
                    </c:if>
                </div>	
            </div>
        </div>	
    </body>
</html>
