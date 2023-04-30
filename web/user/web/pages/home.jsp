<%-- 
    Document   : home
    Created on : Apr 24, 2023, 1:58:10 PM
    Author     : Arya
--%>
<%@ page language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="Bookstore.dbConnection" %>
<%@ page import="Bookstore.Cookies" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    Cookies cookies = new Cookies();
    if (!cookies.checkCookies(request)) {
        response.sendRedirect("../index.jsp");
    }
    Connection conn = null;
    dbConnection connector = null;
    connector = new dbConnection();
    conn = connector.connectDb();

    PreparedStatement billBoardStmt = null, featuredBooksStmt = null, popularBooksStmt = null;
    ResultSet billBoardRs = null, featuredBooksRs = null, popularBooksRs = null;


%>



<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Book Store</title>
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
                        <div class="col-md-6" hidden>
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
                                            <i  hidden class="icon icon-search"></i>
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
                                        <li class="menu-item active"><a href="#home" data-effect="Home">Home</a></li>

                                        <li class="menu-item has-sub">
                                            <a href="#pages" class="nav-link" data-effect="Pages">View Books</a>

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









        <%    String name1 = null, name2 = null;
            String desc1 = null, desc2 = null;
            String url1 = null, url2 = null;
            int id1 = 0, id2 = 0;
            billBoardStmt = conn.prepareStatement("SELECT * FROM books  where quantity >0 LIMIT 2;");
            billBoardRs = billBoardStmt.executeQuery();
            boolean flag = true;
            while (billBoardRs.next()) {
                if (flag) {
                    name1 = billBoardRs.getString("bookname");
                    desc1 = billBoardRs.getString("descreption");
                    url1 = billBoardRs.getString("image_path");
                    id1 = billBoardRs.getInt("bookid");
                    flag = false;
                } else {
                    name2 = billBoardRs.getString("bookname");
                    desc2 = billBoardRs.getString("descreption");
                    url2 = billBoardRs.getString("image_path");
                    id2 = billBoardRs.getInt("bookid");
                }

            }
        %>


        <!-- Bill board -->
        <section id="billboard">

            <div class="container">
                <div class="row">
                    <div class="col-md-12">

                        <button class="prev slick-arrow">
                            <i class="icon icon-arrow-left"></i>
                        </button>

                        <div class="main-slider pattern-overlay">
                            <div class="slider-item">
                                <div class="banner-content">
                                    <h2 class="banner-title"><%= name1%></h2>
                                    <p><%= desc1%></p>
                                    <div class="btn-wrap">
                                        <button type="button" class="add-to-cart" id="<%=  "banner" + id1%>" value="<%= id1%>" class="btn add-to-cart"  onclick="addToCart(this.value, this.id)"  >Add to cart <i class="btn-outline-accent"></i></button>
                                    </div>
                                </div><!--banner-content--> 
                                <img src="<%= url1%>" alt="banner" class="banner-image">
                            </div><!--slider-item-->

                            <div class="slider-item">
                                <div class="banner-content">
                                    <h2 class="banner-title"><%= name2%></h2>
                                    <p><%= desc2%></p>
                                    <div class="btn-wrap">
                                        <button type="button" class="add-to-cart"  id="<%= "banner" + id2%>" value="<%= id2%>"  class="btn add-to-cart"  onclick="addToCart(this.value, this.id)" >Add to cart <i class="btn-outline-accent"></i></button>							</div>
                                </div><!--banner-content--> 
                                <img src="<%= url2%>" alt="banner" class="banner-image">
                            </div><!--slider-item-->

                        </div><!--slider-->

                        <button class="next slick-arrow">
                            <i class="icon icon-arrow-right"></i>
                        </button>

                    </div>
                </div>
            </div>

        </section>



        <section id="featured-books">
            <div class="container">
                <div class="row">
                    <div class="col-md-12">

                        <div class="section-header align-center">

                            <h2 class="section-title">Popular Books</h2>
                        </div>

                        <div class="product-list" data-aos="fade-up">
                            <div class="row">

                                <%
                                    featuredBooksStmt = conn.prepareStatement("SELECT DISTINCT * FROM books WHERE quantity > 0 ORDER BY RAND() LIMIT 12;");
                                    featuredBooksRs = featuredBooksStmt.executeQuery();

                                    while (featuredBooksRs.next()) {
                                %>


                                <div class="col-md-3">
                                    <figure class="product-style">
                                        <img src="<%= featuredBooksRs.getString("image_path")%>" alt="Books" class="product-item">
                                        <button type="button" class="add-to-cart" id="<%= "featuredBooks" + featuredBooksRs.getInt("bookid")%>" value="<%= featuredBooksRs.getInt("bookid")%>" data-product-tile="add-to-cart" onclick="addToCart(this.value, this.id)" >Add to Cart</button>
                                        <figcaption>
                                            <h3> <%= featuredBooksRs.getString("bookname")%></h3>
                                            <p><%= featuredBooksRs.getString("author")%></p>
                                            <div class="item-price"> &#x20B9 <%= featuredBooksRs.getInt("price")%></div>
                                        </figcaption>
                                    </figure>
                                </div>


                                <%

                                    }
                                    conn.close();
                                %>

                            </div><!--ft-books-slider-->				
                        </div><!--grid-->


                    </div><!--inner-content-->
                </div>


            </div>
        </section>






        <section id="quotation" class="align-center">
            <div class="inner-content">
                <h2 class="section-title divider">Quote of the day</h2>
                <blockquote data-aos="fade-up">
                    <q>“The more that you read, the more things you will know. The more that you learn, the more places you’ll go.”</q>
                    <div class="author-name">Dr. Seuss</div>			
                </blockquote>
            </div>		
        </section>





        <script src="js/jquery-1.11.0.min.js"></script>
        <script src="js/plugins.js"></script>
        <script src="js/script.js"></script> 
        <script src="js/requests.js"></script> 


    </body>
</html>	