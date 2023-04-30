<%-- 
    Document   : shop
    Created on : Apr 28, 2023, 4:21:13 PM
    Author     : Arya
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="Bookstore.dbConnection" %>
<%@ page import="Bookstore.Cookies" %>

<%
    Cookies cookies = new Cookies();
    if (!cookies.checkCookies(request)) {
        response.sendRedirect("../index.jsp");
    }
    Connection conn = null;
    dbConnection connector = null;
    connector = new dbConnection();
    conn = connector.connectDb();

    PreparedStatement stmt;
    ResultSet dataSet, checkSet;


%>





<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Book Store -: Shop</title>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="format-detection" content="telephone=no">
        <meta name="apple-mobile-web-app-capable" content="yes">
        <meta name="author" content="">
        <meta name="keywords" content="">
        <meta name="description" content="">

        <link rel="stylesheet" type="text/css" href="css/normalize.css">
        <link rel="stylesheet" type="text/css" href="icomoon/icomoon.css">
        <link rel="stylesheet" type="text/css" href="css/vendor.css">
        <link rel="stylesheet" type="text/css" href="style.css">

        <!-- script
        ================================================== -->
        <script src="js/modernizr.js"></script>

    </head>

    <body>

        <div id="header-wrap">

            <div hidden class="top-content">
                <div class="container">
                    <div class="row">
                        <div class="col-md-6">
                            <div class="social-links">
                                <ul>
                                    <li>
                                        <a href="#"><i hidden class="icon icon-facebook"></i></a>
                                    </li>
                                    <li>
                                        <a href="#"><i hidden  class="icon icon-twitter"></i></a>
                                    </li>
                                    <li>
                                        <a href="#"><i hidden class="icon icon-youtube-play"></i></a>
                                    </li>
                                    <li>
                                        <a href="#"><i  hidden class="icon icon-behance-square"></i></a>
                                    </li>
                                </ul>
                            </div><!--social-links-->
                        </div>
                        <div class="col-md-6">
                            <div class="right-element">
                                <a href="#" class="user-account for-buy"><i hidden class="icon icon-user"></i><span hidden>Account</span></a>
                                <a href="#" class="cart for-buy"><i class="icon icon-clipboard" hidden></i><span hidden>Cart:(0 $)</span></a>

                                <div class="action-menu">

                                    <div class="search-bar">
                                        <a href="#" class="search-button search-toggle" data-selector="#header-wrap">
                                            <i hidden class="icon icon-search"></i>
                                        </a>
                                        <form role="search" method="get" class="search-box">
                                            <input class="search-field text search-input" placeholder="Search" type="search" hidden>
                                        </form>
                                    </div>
                                </div>

                            </div><!--top-right-->
                        </div>

                    </div>
                </div>
            </div><!--top-content-->

            <header id="header">
                <div class="container">
                    <div class="row">

                        <div class="col-md-2">
                            <div class="main-logo">
                                <a href="index.html"><img src="images/client-image3.png" alt="logo"></a>
                            </div>

                        </div>

                        <div class="col-md-10">

                            <nav id="navbar">
                                <div class="main-menu stellarnav">
                                    <ul class="menu-list">
                                        <li ><a href="home.jsp" data-effect="Home">Home</a></li>

                                        <li class="menu-item has-sub">
                                            <a href="#pages" class="nav-link menu-item active" data-effect="Pages">View Books</a>

                                            <ul>
                                                <li class="active" ><a value="comic" id="comic" style="cursor: pointer;" >Comic</a></li>
                                                <li><a style="cursor: pointer;" value="story" id="story" >Story</a></li>
                                                <li><a style="cursor: pointer;" value="horror" id="horror" >Horror</a></li>
                                                <li><a style="cursor: pointer;" value="education" id="education" >Education</a></li>
                                                <li><a style="cursor: pointer;" value="novel" id="novel" >Novel</a></li>
                                                <li><a style="cursor: pointer;" value="gk" id="gk" >GK</a></li>
                                            </ul>

                                        </li>
                                        <li class="menu-item"><a href="cart.jsp" class="nav-link" data-effect="Shop">Cart</a></li>
                                        <li class="menu-item"><a href="../logout.jsp" class="nav-link" data-effect="Articles">Log out</a></li>

                                    </ul>

                                    <div class="hamburger">
                                        <span class="bar"></span>
                                        <span class="bar"></span>
                                        <span class="bar"></span>
                                    </div>

                                </div>
                            </nav>

                        </div>

                    </div>
                </div>
            </header>

        </div><!--header-wrap-->

        <div>
            <div class="container">
                <div class="row">
                    <div class="col-md-12">			
                        <div class="colored">
                            <h1 class="page-title" hidden >Shop</h1>
                            <div class="breadcum-items">
                                <span class="item"><a href="home.jsp">Home /</a></span>
                                <span class="item colored">Shop</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div><!--site-banner-->






        <section class="padding-large">
            <div class="container">
                <div class="row">

                    <div class="products-grid grid">

                        <%    String category = null;
                            category = request.getParameter("category");
                            int count = 0;
                            stmt = conn.prepareStatement("SELECT * FROM books WHERE category = ? and quantity > 0 LIMIT 15");
                            stmt.setString(1, category);
                            checkSet = dataSet = stmt.executeQuery();
                            while (checkSet.next()) {
                                count++;
                            }
                            if (count == 0) {
                        %>
                        <section id="quotation" class="align-center">
                            <div class="inner-content">
                                <h3 class="section-title divider">No books found :-(</h3>

                            </div>		
                        </section>
                        <%
                        } else {

                            stmt = conn.prepareStatement("SELECT * FROM books WHERE category = ? LIMIT 15");
                            stmt.setString(1, category);
                            dataSet = stmt.executeQuery();

                            while (dataSet.next()) {
                        %>




                        <figure class="product-style">
                            <img src="<%= dataSet.getString("image_path")%>" alt="Books" class="product-item">
                            <button type="button" class="add-to-cart" data-product-tile="add-to-cart" value="<%= dataSet.getInt("bookid")%>" id="<%= "dataSet" + dataSet.getInt("bookid")%>" onclick="addToCart(this.value, this.id)" >Add to Cart</button>
                            <figcaption>
                                <h3><%= dataSet.getString("bookname")%></h3>
                                <p><%= dataSet.getString("author")%></p>
                                <div class="item-price">&#x20B9 <%= dataSet.getInt("price")%></div>
                            </figcaption>
                        </figure>



                        <%
                                }//while loop
                            }//else loop
%>





                    </div>

                </div>
            </div>
        </section>

        <script src="js/jquery-1.11.0.min.js"></script>
        <script src="js/plugins.js"></script>
        <script src="js/script.js"></script> 
        <script src="js/requests.js"></script> 


    </body>
</html>	