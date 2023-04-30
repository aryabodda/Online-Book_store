<%-- 
    Document   : logout
    Created on : Apr 26, 2023, 2:39:41 PM
    Author     : Arya
--%>
<%@ page import="Bookstore.Cookies" %>
<%
    Cookies cookies = new Cookies();
    if (cookies.checkCookies(request)) {
        cookies.deleteCookie(response);
    } else {
        response.sendRedirect("index.jsp");
    }
%>
<div style="background-image: url('https://cdn.pixabay.com/photo/2015/12/03/08/50/paper-1074131_960_720.jpg'); background-size: cover; background-position: center; width: 100%; height: 100%; display: flex; align-items: center; justify-content: center;">
    <div style="background-color: rgba(255, 255, 255, 0.8); padding: 20px; text-align: center;">
        <h1>Successfully logged out!</h1>
        <a href="index.jsp" ><button type="button" >login</button> </a>
    </div>
</div>
