<%-- 
    Document   : signup
    Created on : Apr 23, 2023, 5:05:26 PM
    Author     : Arya
--%> 
<%@ page import="java.sql.*" %>
<%@ page import="Bookstore.dbConnection" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.Date" %>


<%
    dbConnection connector = null;
    // Retrieve form data submitted by the client
    String username = request.getParameter("user-name");
    String email = request.getParameter("email");
    String password = request.getParameter("password");
    String dobStr = request.getParameter("dob");
    String number = request.getParameter("number");
    String address = request.getParameter("address");

    if (username != null && email != null && password != null && dobStr != null && number != null && address != null) {
        // Convert date string to Date object

        // Store form data in the database using prepared statements
        String insertSql = "INSERT INTO users (name, email, password, dob, contact, address1,address2,address3,userid) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try {
            connector = new dbConnection();
            Connection conn = connector.connectDb();
            PreparedStatement pstmt = conn.prepareStatement(insertSql);
            pstmt.setString(1, username);
            pstmt.setString(2, email);
            pstmt.setString(3, password);
            pstmt.setString(4, dobStr);
            pstmt.setString(5, number);
            pstmt.setString(6, address);
            pstmt.setString(7, address);
            pstmt.setString(8, address);
            pstmt.setString(9, userid());
            pstmt.executeUpdate();

//         account created
            boolean res = true;
%>
<% if (res) { %>
<div style="background-image: url('https://cdn.pixabay.com/photo/2015/12/03/08/50/paper-1074131_960_720.jpg'); background-size: cover; background-position: center; width: 100%; height: 100%; display: flex; align-items: center; justify-content: center;">
    <div style="background-color: rgba(255, 255, 255, 0.8); padding: 20px; text-align: center;">
        <h1>Your account is created..!</h1>
        <p>Please click the below button to login..!</p>
        <a href="index.jsp" ><button type="button" >Login</button> </a>
    </div>
</div>
<% } %>
<%

} catch (SQLException e) {

    System.out.println(e.getMessage());

//account not created
    boolean flag = true;
%>
<% if (flag) { %>
<div style="background-image: url('https://cdn.pixabay.com/photo/2015/12/03/08/50/paper-1074131_960_720.jpg'); background-size: cover; background-position: center; width: 100%; height: 100%; display: flex; align-items: center; justify-content: center;">
    <div style="background-color: rgba(255, 255, 255, 0.8); padding: 20px; text-align: center;">
        <h1>user already exists..!</h1>
        <p>Please click the below button to login..!</p>
        <a href="index.jsp" ><button type="button" >Login</button> </a>
    </div>
</div>
<% } %>
<%

        } finally {

        }
    } else {

    }

%>



<%!
    String userid() {
// Generate a 10-digit random number
        long randomNumber = (long) (Math.random() * 10000000000L);

// return the random number
        return Long.toString(randomNumber);

    }
%>
