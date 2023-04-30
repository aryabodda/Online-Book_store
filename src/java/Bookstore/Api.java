/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Bookstore;

import java.sql.*;
import java.util.*;

/**
 *
 * @author Arya
 */
public class Api {

    public dbConnection dbConnection = null;
    public PreparedStatement stmt = null;
    public ResultSet rs = null;
    public Connection conn = null;

    public Api() {
        dbConnection = new dbConnection();
        conn = dbConnection.connectDb();
    }

    public boolean addToCart(String bookId, String userId) {
        Api api = new Api();
        try {
            stmt = conn.prepareStatement("INSERT INTO cart (bookid , userid ) VALUES(?, ?)");
            stmt.setString(1, bookId);
            stmt.setString(2, userId);
            stmt.executeUpdate();
            conn.close();
            stmt.close();
            return true;
        } catch (SQLException e) {
            System.out.print(e);
            return false;
        }
    } //addToCart method

    public boolean removeBookFromCart(String bookId, String userId) {
        String sql = "DELETE FROM cart WHERE bookid = ? and userid = ?";
        Api api = new Api();
        try {
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, bookId);
            stmt.setString(2, userId);
            stmt.executeUpdate();
            stmt.close();
            conn.close();
            return true;
        } catch (SQLException e) {
            System.out.print(e);
            return false;
        }

    }// removeBookFromCart method

    public boolean addItem(String bookId, String userId) {
        String sql = "UPDATE cart SET quantity = quantity +1 WHERE bookid = ? and userid = ? and sum(quantity) < (SELECT books.quantity FROM books WHERE bookid = ? )";
        sql = "UPDATE cart \n"
                + "SET quantity = quantity + 1 \n"
                + "WHERE bookid = ? \n"
                + "AND userid = ? \n"
                + "AND quantity < (SELECT b.quantity FROM books b WHERE b.bookid = ?)";
        Api api = new Api();
        try {
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, bookId);
            stmt.setString(2, userId);
            stmt.setString(3, bookId);
            stmt.executeUpdate();
            stmt.close();
            conn.close();
            return true;
        } catch (SQLException e) {
            System.out.print(e);
            return false;
        }
    }//addItem method

    public boolean removeItem(String bookId, String userId) {
        String sql = "UPDATE cart SET quantity = quantity -1 WHERE bookid = ? and userid = ?";
        Api api = new Api();
        try {
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, bookId);
            stmt.setString(2, userId);
            stmt.executeUpdate();
            stmt.close();
            conn.close();
            return true;
        } catch (SQLException e) {
            System.out.print(e);
            return false;
        }
    }//removeItem method

    public int getTotalAmount(String userId) {
        Api api = new Api();
        int price = 0;
        String sql = "SELECT books.price , cart.quantity FROM books , cart WHERE books.bookid = cart.bookid AND userid = ?";
        try {
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, userId);
            rs = stmt.executeQuery();
            while (rs.next()) {
                price = price + rs.getInt("price") * rs.getInt("quantity");
            }
            conn.close();
            return price;
        } catch (SQLException e) {
            System.out.println(e);
            return 0;
        }
    }

    public boolean updateSales(String userId) {
        int total = 0;
        PreparedStatement deleteCart = null;
        PreparedStatement updateBooks = null;
        ArrayList<Integer> priceList = new ArrayList<Integer>();
        ArrayList<String> bookNameList = new ArrayList<String>();
        ArrayList<Integer> quantityList = new ArrayList<Integer>();
        ArrayList<Integer> totalPriceList = new ArrayList<Integer>();
        ArrayList<String> bookIdsList = new ArrayList<String>();
        Api api = new Api();

        String sql = "SELECT books.price , books.bookname , books. bookid ,cart.quantity  FROM books ,  cart WHERE books.bookid = cart.bookid AND userid = ?";  //getting details from cart and books table 
        try {
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, userId);
            rs = stmt.executeQuery();
            while (rs.next()) {
                priceList.add(rs.getInt("price"));//sungle book price from books
                bookNameList.add(rs.getString("bookname"));// book name
                quantityList.add(rs.getInt("quantity"));// quantity from cart;
                bookIdsList.add(rs.getString("bookid"));// book id
                totalPriceList.add(rs.getInt("price") * rs.getInt("quantity"));//total amount
            }
            String deleteSql = "DELETE FROM cart WHERE userid = ? AND bookid = ?";// deleteing book from cart
            deleteCart = conn.prepareStatement(deleteSql);// delete from cart

            sql = "INSERT INTO sales (userid , bookname , price , quantity , total ) VALUES( ? , ? , ? , ? , ? )";
            stmt = conn.prepareStatement(sql);// updates sales

            sql = "UPDATE books SET quantity = quantity - ? WHERE bookid = ?";
            updateBooks = conn.prepareStatement(sql);

            for (int i = 0; i < priceList.size(); i++) {
                stmt.setString(1, userId);
                stmt.setString(2, bookNameList.get(i));
                stmt.setInt(3, priceList.get(i));
                stmt.setInt(4, quantityList.get(i));
                stmt.setInt(5, totalPriceList.get(i));

                deleteCart.setString(1, userId);
                deleteCart.setString(2, bookIdsList.get(i));

                updateBooks.setInt(1, quantityList.get(i));
                updateBooks.setString(2, bookIdsList.get(i));

                stmt.executeUpdate();
                deleteCart.executeUpdate();
                updateBooks.executeUpdate();

            }
            conn.close();
            return true;

        } catch (SQLException e) {
            System.out.println(e);
            return false;
        }
    }

    public static void main(String ar[]) {
        Api api = new Api();
        System.out.println(api.addItem("494351091", "565654 "));
    }

}//class
