
<%@ page import="Bookstore.Cookies" %>
<%
    Cookies cookies = new Cookies();
    if (cookies.checkCookies(request)) {
        response.sendRedirect("pages/home.jsp");
    }
%>



<!DOCTYPE html>
<html lang="en" >
    <head>
        <meta charset="UTF-8">
        <title>User Login/Registration Form </title>
        <link rel='stylesheet' href='https://fonts.googleapis.com/css?family=Open+Sans'><link rel="stylesheet" href="../user-css/style.css">

    </head>
    <body>
        <!-- partial:index.partial.html -->
        <p class="tip">Online Book Store User Signin/Signup</p>
        <div class="cont">
            <div class="form sign-in">
                <h2>Welcome back,</h2>
                <label>
                    <form action="signin.jsp" method="post">
                        <span>Email </span>
                        <input type="text"  name="user-name" required/>
                </label>
                <label>
                    <span>Password</span>
                    <input type="password" name="password" required />
                </label>
                <button type="submit" class="submit">Sign In</button>
                </form>
            </div>
            <div class="sub-cont">
                <div class="img">
                    <div class="img__text m--up">
                        <h2>New here?</h2>
                        <p>Sign up and discover great amount of new opportunities!</p>
                    </div>
                    <div class="img__text m--in">
                        <h2>One of us?</h2>
                        <p>If you already has an account, just sign in. We've missed you!</p>
                    </div>
                    <div class="img__btn">
                        <span class="m--up">Sign Up</span>
                        <span class="m--in">Sign In</span>
                    </div>
                </div>
                <div class="form sign-up">
                    <h2>Time to feel like home,</h2>

                    <form action="signup.jsp" method="post">
                        <label> 
                            <span>User Name</span>
                            <input name="user-name" type="text" required />
                        </label>
                        <label>
                            <span>Email</span>
                            <input name="email" type="email" required />
                        </label>
                        <label>
                            <span>Password</span>
                            <input name="password" type="password" required  />
                        </label>
                        <label>
                            <span>dob</span>
                            <input name="dob" type="date" required />
                        </label>
                        <label>
                            <span>Mobile number</span>
                            <input name="number" type="text" required />
                        </label>

                        <label>
                            <span>Address</span>
                            <input type="text" name="address" cols="5" rows="25" />
                        </label>


                        <button type="submit" class="submit">Sign Up</button>
                    </form>
                </div>
            </div>
        </div>

        <!-- partial -->
        <script  src="../js/script.js"></script>

    </body>
</html>
