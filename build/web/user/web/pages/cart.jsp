<%-- 
    Document   : cart
    Created on : Apr 28, 2023, 9:12:06 PM
    Author     : Arya
--%>

<%@ page language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="Bookstore.dbConnection" %>
<%@ page import="Bookstore.Cookies" %>
<%@ page import="Bookstore.Api" %>
<%@ page import="java.util.*" %>
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

%>








<!doctype html>
<html
    <head>
    <meta charset='utf-8'>
    <meta name='viewport' content='width=device-width, initial-scale=1'>
    <title>Book Store :- Cart</title>
    <link href='https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css' rel='stylesheet'>
    <link href='https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css' rel='stylesheet'>
    <link rel="stylesheet" href="cart-styles.css">
    <link rel="stylesheet" href="alert-style.css">
    <script type='text/javascript' src='https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js'></script>

</head>
<body className='snippet-body'>

    <div class="card">
        <div class="row">
            <div class="col-md-8 cart">      

                <div class="title">
                    <div class="row">
                        <div class="col"><h4><b>Shopping Cart</b></h4></div>

                        <%                            String userId = null;
                            PreparedStatement stmt;
                            ResultSet rs;
                            userId = cookies.getCookieValue(request, "userid");

                            String quantitySql = "SELECT  quantity FROM cart where userid = ? and bookid In (SELECT  bookid FROM cart where userid = ?)";
                            stmt = conn.prepareStatement(quantitySql);// getting rows 
                            stmt.setString(1, userId);
                            stmt.setString(2, userId);
                            rs = stmt.executeQuery();
                            int total = 0;
                            int index = 0;
                            ArrayList<Integer> itemQuantity = new ArrayList<Integer>();// array list to store quantity
                            while (rs.next()) {
                                total = total + rs.getInt("quantity");// total count
                                itemQuantity.add(rs.getInt("quantity"));//adding quantity
                            }
                            index = itemQuantity.size();
                        %>
                        <div class="col align-self-center text-right text-muted"><span id="total"><%= total%> </span> items</div></div>
                </div> 
                <%

                    index--;
                    String sql = "SELECT * FROM books WHERE bookid IN (SELECT  bookid FROM cart where userid = ?)";
                    stmt = conn.prepareStatement(sql);
                    stmt.setString(1, userId);
                    rs = stmt.executeQuery();
                    while (rs.next()) {%>



                <div id="<%= "div" + rs.getInt("bookid")%>" class="row border-top border-bottom">
                    <div class="row main align-items-center">
                        <div class="col-2"><img class="img-fluid" src="<%= rs.getString("image_path")%>"></div>
                        <div class="col">
                            <div class="row"><%= rs.getString("bookname")%></div>
                            <div class="row text-muted"><%= rs.getString("author")%></div>
                        </div>
                        <div class="col">
                            <a href="#"id="<%= "minus" + rs.getInt("bookid")%>" onclick="removeItem(this.id)" >-</a><a href="#" id="<%= "count" + rs.getInt("bookid")%>" class="border"><%= itemQuantity.get(index)%></a><a href="#" id="<%= "plus" + rs.getInt("bookid")%>" onclick="addItem(this.id)" >+</a>
                        </div>
                        <div class="col"> &#x20B9 <%= rs.getInt("price")%><span style="cursor: pointer;" id="<%= "remove" + rs.getInt("bookid")%>" onclick="removeFromCart(this.id)" class="close">&#10005;</span></div>
                    </div>
                </div> 



                <%
                        index--;

                    }
                    conn.close();

                    Api api = new Api();
                    int summaryAmount = api.getTotalAmount(userId);
                %>


                <div class="back-to-shop"><a href="home.jsp">&leftarrow; <span class="text-muted">Back to home</span> </a></div>
            </div>
            <div class="col-md-4 summary">
                <div><h5><b>Summary</b></h5></div>
                <hr>
                <div class="row">
                    <div class="col" style="padding-left:0;">ITEMS <span id="summary"><%= total%></span></div>
                    <div class="col text-right"> &#x20B9 <span id="summaryprice1" > <%= summaryAmount%> </span></div>
                </div>
                <form>
                    <p>SHIPPING</p>
                    <select><option class="text-muted">Standard-Delivery- &#x20B9 0.00</option></select>
                    <p hidden >GIVE CODE</p>
                    <input hidden id="code" placeholder="Enter your code">
                </form>
                <div class="row" style="border-top: 1px solid rgba(0,0,0,.1); padding: 2vh 0;">
                    <div class="col">TOTAL PRICE</div>
                    <div class="col text-right">&#x20B9 <span id="summaryprice2"> <%= summaryAmount%> </span></div>
                </div>
                <button class="btn" id="checkout" onclick="updateSales()">CHECKOUT</button>
            </div>
        </div>

    </div>

    <script src="js/jquery-1.11.0.min.js"></script>
    <script src="js/plugins.js"></script>
  <script src='https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js'></script><script  src="alert-script.js"></script>

    <script src="js/requests.js"></script> 
</body>
</html>