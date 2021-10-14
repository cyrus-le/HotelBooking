<%-- 
    Document   : login
    Created on : Oct 20, 2020, 9:49:17 AM
    Author     : ASUS
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
        <link rel="stylesheet" href="./css/loginPage.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
        <title>Login Page</title>
    </head>
    <body>
        <header>
            <div class="container">
                <div class="row">
                    <div class="col-lg-3">
                        <div style="padding: 15px 0;">
                            <a href="search"><img src="https://scontent.fsgn2-3.fna.fbcdn.net/v/t1.15752-9/121374499_3395774180516050_2675481738071891303_n.png?_nc_cat=108&_nc_sid=ae9488&_nc_ohc=syvXp2x97ZwAX-2ncCU&_nc_ht=scontent.fsgn2-3.fna&oh=bd414095a61b475d16bff87fead41080&oe=5FA7D9A5" alt=""></a>
                        </div>
                    </div>
                </div>
            </div>
        </header>
        <div class="container">
            <div class="row">
                <div class="col-md-6 col-md-offset-3">
                    <div class="panel panel-login">
                        <div class="panel-heading">
                            <div class="row">
                                <div class="col-md-6 col-md-offset-3" style="text-align: center;">
                                    <h1>Login</h1>
                                </div>
                            </div>
                            <hr>
                        </div>
                        <div class="panel-body">
                            <div class="row">
                                <div class="col-lg-12">
                                    <form id="login-form" action="login" method="POST" role="form" style="display: block;">
                                        <div class="form-group">
                                            <label>User Name: </label>
                                            <input type="text" name="txtUserName" tabindex="1" class="form-control" placeholder="Username" value="${param.txtUserName}">
                                        </div>
                                        <div class="form-group">
                                            <label>Password: </label>
                                            <input type="password" name="txtPassword" id="password" tabindex="2" class="form-control" placeholder="Password">
                                        </div>
                                        <div class="form-group">
                                            <c:set var="notfound" value="${requestScope.NOTFOUND}"/>
                                            <c:if test="${not empty notfound}">
                                                <p>
                                                    <font color="red">${notfound}</font>
                                                </p>
                                            </c:if>
                                        </div>                                       
                                        <div class="form-group">
                                            <div class="row">
                                                <div class="col-sm-8 col-sm-offset-2">
                                                    <input class="btn btn-lg btn-primary btn-login btn-block text-uppercase" type="submit" value="Login"/>
                                                </div>
                                            </div>
                                        </div>
                                    </form> 

                                    <div class="col-xs-6 col-xs-offset-3" style="text-align: center">
                                        <p>Don't have an account? <a href="SignUpPage" id="register-form-link">Sign up</a></p>                                        
                                    </div>
                                    <div class="col-xs-6 col-xs-offset-3" style="text-align: center">
                                        <p>View hotel without login - <a href="search" id="register-form-link">View</a></p>                                        
                                    </div>
                                    <br>				
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
