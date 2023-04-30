<%-- 
    Document   : homeAPIs
    Created on : Apr 27, 2023, 11:52:35 PM
    Author     : Arya
--%>
<%@ page import="Bookstore.Api" %>
<%@ page import="Bookstore.Cookies" %>
<%
    //decleration and initialization part
    String bookId = null;
    String userId = null;
    String requestCode = null;
    int code = 0;
    bookId = request.getParameter("bookid");
    requestCode = request.getParameter("code");
    code = getCode(requestCode);
//getting userid from request
    Cookies cookies = new Cookies();
    userId = cookies.getCookieValue(request, "userid");
    Api api = new Api();
%>

<%!
    int getCode(String requestCode) {
        if (requestCode != null) {
            return Integer.parseInt(requestCode);
        } else {
            return 0;
        }
    }
%>





<%
//adding book to cart
    if (bookId != null && userId != null && code == 10) {

        boolean result = api.addToCart(bookId, userId);
        out.println(result);

    }

%>


<%// removing book from cart
    if (bookId != null && userId != null && code == 20) {

        boolean result = api.removeBookFromCart(bookId, userId);
        out.println(result);

    }

%>


<%// adding single item
    if (bookId != null && userId != null && code == 30) {

        boolean result = api.addItem(bookId, userId);
        out.println(result);

    }

%>

<%// removing single item
    if (bookId != null && userId != null && code == 40) {

        boolean result = api.removeItem(bookId, userId);
        out.println(result);

    }

%>



<%// get total amount
    if (code == 50) {

        int result = api.getTotalAmount(userId);
        out.println(result);

    }

%>

<%// get total amount
    if (code == 60) {

        boolean result = api.updateSales(userId);
        out.println(result);

    }

%>