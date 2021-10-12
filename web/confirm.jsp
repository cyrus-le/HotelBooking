<%-- 
    Document   : confirm
    Created on : Nov 1, 2020, 1:15:31 PM
    Author     : ASUS
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
        <link rel="stylesheet" href="css/checkout.css" type="text/css">
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>
        <title>Confirm Page</title>
    </head>

    <body>
        <!-- Breadcrumb Section Begin -->
        <c:set var="userId" value="${sessionScope.USERID}"/>
        <c:if test="${not empty userId}">
            <c:set var="userInfor" value="${sessionScope.USERINFOR}"/>
            <c:if test="${not empty userInfor}">
                <c:if test="${userInfor.role != 2}">
                    <c:redirect url="LoginPage"/>
                </c:if>
                <header>
                    <div class="container">
                        <div class="row">
                            <div class="col-lg-3">
                                <div style="padding: 15px 0;">
                                    <a href="search"><img src="https://scontent.fsgn2-3.fna.fbcdn.net/v/t1.15752-9/121374499_3395774180516050_2675481738071891303_n.png?_nc_cat=108&_nc_sid=ae9488&_nc_ohc=syvXp2x97ZwAX-2ncCU&_nc_ht=scontent.fsgn2-3.fna&oh=bd414095a61b475d16bff87fead41080&oe=5FA7D9A5" alt=""></a>
                                </div>
                            </div>
                            <div class="col-lg-6 checkout-header">
                                <h2>CHECKOUT</h2>
                            </div>
                        </div>
                    </div>
                </header>
                <!-- Breadcrumb Section End -->

                <!-- Checkout Section Begin -->
                <section class="checkout spad">
                    <div class="container">            
                        <div class="checkout-form" style="margin-top: 50px">
                            <h4>Billing Details</h4>
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="row">
                                        <div class="col-lg-6">
                                            <div class="checkout-input">
                                                <p>User name</p>
                                                <input type="text" placeholder="${userInfor.name}" disabled>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-lg-6">
                                            <div class="checkout-input">
                                                <p>Address</p>
                                                <input type="text" placeholder="${userInfor.address}" disabled>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="col-lg-6">
                                            <div class="checkout-input">
                                                <p>Email</p>
                                                <input type="text" placeholder="${userInfor.email}" disabled>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="checkout-order">
                                        <h4>Your Order</h4>                                        
                                        <div class="checkout-order-products">Products</div>

                                        <c:set var="cart" value="${sessionScope.CART}"/>
                                        <c:if test="${not empty cart}">                    
                                            <c:if test="${not empty cart.items}">
                                                <c:set var="hotelNameList" value="${requestScope.NAMELIST}"/>
                                                <c:set var="hotelPriceList" value="${requestScope.PRICELIST}"/>
                                                <c:set var="totalPrice" value="${requestScope.TOTALPRICE}"/>
                                                <c:set var="discount" value="${requestScope.DISCOUNTINFOR}"/>
                                                <ul>
                                                    <c:forEach var="item" items="${cart.items}" varStatus="counter">

                                                        <li>
                                                            <b>${hotelNameList[counter.count - 1]}</b>
                                                            <p>From: ${item.key.checkInDate} | To: ${item.key.checkOutDate} | Room Type: ${item.key.roomType}</p>
                                                            <p>Price: ${hotelPriceList[counter.count - 1]} | Quantity: ${item.value}</p>
                                                            <hr>
                                                        </li>

                                                    </c:forEach>
                                                </ul>

                                                <div class="checkout-order-total">Total <span>${totalPrice}</span></div>
                                                <c:if test="${not empty discount}">
                                                    <div class="checkout-order-total">Discount ${discount.discountPercent}% <span>${totalPrice * discount.discountPercent / 100}</span></div>
                                                    <div class="checkout-order-total">Final Price<span>${totalPrice - totalPrice * discount.discountPercent / 100}</span></div>
                                                </c:if>

                                                <form action="checkout">
                                                    <input type="hidden" name="discountCodeId" value="${discount.codeId}" />
                                                    <input type="submit" class="btn btn-primary btn-block" value="Check Out" />
                                                    <input type="hidden" name="txtEmail" value="${sessionScope.USER_EMAIL}" />
                                                </form>
                                            </c:if>
                                        </c:if>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </section>
                <!-- Checkout Section End -->
            </c:if>
        </c:if>
        <c:if test="${empty userId}">
            <c:redirect url="LoginPage"/>
        </c:if>

        <!-- Js Plugins -->
        <script src="js/jquery-3.3.1.min.js"></script>
        <script src="js/main.js"></script>
    </body>
</html>
