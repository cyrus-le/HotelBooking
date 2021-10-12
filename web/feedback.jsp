<%-- 
    Document   : feedback
    Created on : Oct 10, 2021, 8:47:35 PM
    Author     : Cyrus
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Feedback</title>
        <link rel="stylesheet" href="./css/index.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.14.0/css/all.min.css">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
    </head>
    <style>
        .rating {
            display: flex;
            flex-direction: row-reverse;
            justify-content: center
        }

        .rating>input {
            display: none
        }

        .rating>label {
            position: relative;
            width: 1em;
            font-size: 6vw;
            color: #FFD600;
            cursor: pointer
        }

        .rating>label::before {
            content: "\2605";
            position: absolute;
            opacity: 0
        }

        .rating>label:hover:before,
        .rating>label:hover~label:before {
            opacity: 1 !important
        }

        .rating>input:checked~label:before {
            opacity: 1
        }

        .rating:hover>input:checked~label:before {
            opacity: 0.4
        }

        body {
            background: #7a7a7a;
        }

        .checked>input:checked~label:after {
            opacity: 1
        }

        h1 {
            margin-top: 150px
        }

        p {
            font-size: 1.2rem
        }
        @media only screen and (max-width: 600px) {
            h1 {
                font-size: 14px
            }

            p {
                font-size: 12px
            }
        }
    </style>

    <body class="bg-light">


        <div class="container">

            <c:set var="dto" value="${requestScope.OrderDetailsDTO}"/>

            <c:if test="${not empty dto}">



                <p class="text-monospace ">Orderdetail ID: ${dto.orderDetailID} </p> 
                <p class="text-monospace ">Hotel ID: ${dto.hotelID} </p> 
                <p class="text-monospace ">Hotel Name: ${dto.hotelName} </p> 
                <p class="text-monospace ">Room ID: ${dto.roomID} </p> 
                <p class="text-monospace ">Quantity: ${dto.quantity} </p> 
                <p class="text-monospace ">Room Price: ${dto.roomPrice} </p> 
                <p class="text-monospace ">From Date: ${dto.fromDate} </p>
                <p class="text-monospace ">To Date: ${dto.toDate} </p> 

                <img class="img-thumbnail mx-auto d-flex justify-content-center" src="${dto.hotelImage}">

            </c:if>
            <hr />


            <c:set var="feedback" value="${requestScope.FeedbackDTO}"/>
            <c:set var="userId" value="${sessionScope.USERID}"/>
            <c:if test="${empty feedback}">
                <form method="POST" action="feedback" class="form-group">
                    <input type="hidden" name="txtUserID" value="${userId}"/>
                    <input type="hidden" name="txtHotelID" value="${dto.hotelID}"/>
                    <input type="hidden" name="txtOrderDetailID" value="${dto.orderDetailID}"/>

                    <h1>Star rating </h1>
                    <div class="rating">
                        <input type="radio" name="rating" value="10" id="10">
                        <label for="10">☆</label> <input type="radio" name="cboFeedback" value="9" id="9"/>
                        <label for="9">☆</label> <input type="radio" name="cboFeedback" value="8" id="8"/>
                        <label for="8">☆</label> <input type="radio" name="cboFeedback" value="7" id="7"/>
                        <label for="7">☆</label> <input type="radio" name="cboFeedback" value="6" id="6"/>
                        <label for="6">☆</label>  <input type="radio" name="cboFeedback" value="5" id="5"/>
                        <label for="5">☆</label> <input type="radio" name="cboFeedback" value="4" id="4"/>
                        <label for="4">☆</label> <input type="radio" name="cboFeedback" value="3" id="3">
                        <label for="3">☆</label> <input type="radio" name="cboFeedback" value="2" id="2">
                        <label for="2">☆</label> <input type="radio" name="cboFeedback" value="1" id="1">
                        <label for="1">☆</label> 

                    </div>
                    <button type="submit" class="btn btn-success d-flex justify-content-center">Rate</button>
                </form>

            </c:if>

            <c:if test="${not empty feedback}">
                <c:forEach var="i" begin="1" end="10" step="1">

                    <div class="rating checked"> 

                        <c:if test="${i <= feedback.point}" >
                            <input checked type="radio" name="cboFeedback" value="${i}" id="${i}">        
                        </c:if>
                        <label for="${i}">☆</label> 
                    </div>     
                </c:forEach>
            </c:if>


        </div>


        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
    </body>

</html>
