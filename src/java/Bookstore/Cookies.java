/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Bookstore;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Arya
 */
public class Cookies {

    public void setCookie(HttpServletResponse response, String userName, String id) {
        int cookieAgeInSeconds = 60 * 60 * 24 * 7; // 1 week

        Cookie userID = new Cookie("userid", id);
        userID.setMaxAge(cookieAgeInSeconds);
        userID.setPath("/");

        Cookie name = new Cookie("name", userName);
        name.setMaxAge(cookieAgeInSeconds);
        name.setPath("/");

        response.addCookie(userID);
        response.addCookie(name);

    }

    public static boolean checkCookies(HttpServletRequest request) {
        // Check if "name" cookie is set
        Cookie[] cookies = request.getCookies();
        boolean nameCookieFound = false;
        boolean userIdCookieFound = false;
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (cookie.getName().equals("name")) {
                    nameCookieFound = true;
                }
                if (cookie.getName().equals("userid")) {
                    userIdCookieFound = true;
                }
            }
        }
        // Return message indicating whether cookies are set or not
        return nameCookieFound && userIdCookieFound;
    }

    public void deleteCookie(HttpServletResponse response) {

        int cookieAgeInSeconds = 0; // 1 week

        Cookie userID = new Cookie("userid", "");
        userID.setMaxAge(cookieAgeInSeconds);
        userID.setPath("/");

        Cookie name = new Cookie("name", "");
        name.setMaxAge(cookieAgeInSeconds);
        name.setPath("/");

        response.addCookie(userID);
        response.addCookie(name);

    }

    public String getCookieValue(HttpServletRequest request, String name) {
        String value = null;
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (cookie.getName().equals(name)) {
                    value = cookie.getValue();
                    break;
                }
            }
        }
        return value;
    }

}
