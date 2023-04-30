<%@ page language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="Bookstore.dbConnection" %>
<%@ page import="Bookstore.Cookies" %>


<%

    String username = request.getParameter("user-name");
    String password = request.getParameter("password");

    if (username != null && password != null) {
        // check username and password against the database
        boolean validCredentials = checkCredentials(username, password, response);

        if (validCredentials) {
            // redirect to home page
            response.sendRedirect("pages/home.jsp");
        } else {
            // back to login page
            boolean flag = true;
%>
<% if (flag) { %>
<div style="background-image: url('https://cdn.pixabay.com/photo/2015/12/03/08/50/paper-1074131_960_720.jpg'); background-size: cover; background-position: center; width: 100%; height: 100%; display: flex; align-items: center; justify-content: center;">
    <div style="background-color: rgba(255, 255, 255, 0.8); padding: 20px; text-align: center;">
        <h1>Your username or password is incorrect!</h1>
        <p>Please click the below button to retry..!</p>
        <a href="index.jsp" ><button type="button" >Retry</button> </a>
    </div>
</div>
<% }
        }
    } else {
        // show login page with form
        response.sendRedirect("index.jsp");// if validation is not satisfied
    }
%>

<%!
    // function to check credentials against database
    private boolean checkCredentials(String username, String password, HttpServletResponse response) {
        Connection con = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        dbConnection connector = null;

        try {
            // connect to database
            connector = new dbConnection();
            con = connector.connectDb();
            // prepare statement to query for username and password
            stmt = con.prepareStatement("SELECT userid  FROM users WHERE BINARY email = ? AND BINARY password = ?");
            stmt.setString(1, username);
            stmt.setString(2, password);

            // execute query and check if there is a matching record
            rs = stmt.executeQuery();
            boolean flag = false;
            while (rs.next()) {
                flag = true;
                String id = rs.getString("userid");
                Cookies cookies = new Cookies();
                cookies.setCookie(response, username, id);//setting cookie

            }
            return flag;

        } catch (Exception e) {
            String error = e.getMessage();

            return false;
        } finally {

            try {
                if (rs != null) {
                    rs.close();
                }
            } catch (Exception e) {
            }
            try {
                if (stmt != null) {
                    stmt.close();
                }
            } catch (Exception e) {
            }
            try {
                if (con != null) {
                    con.close();
                }
            } catch (Exception e) {
            }
        }
    }
%>
