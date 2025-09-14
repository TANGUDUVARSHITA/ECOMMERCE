package controller;

import util.DBConnection;
import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.sql.*;

@WebServlet("/CheckoutServlet")
public class CheckoutServlet extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            resp.sendRedirect("login.jsp");
            return;
        }

        int userId = (int) session.getAttribute("userId");
        String address = req.getParameter("address");
        String payment = req.getParameter("payment");

        Connection con = null;
        try {
            con = DBConnection.getConnection();
            con.setAutoCommit(false);

            // Calculate total
            PreparedStatement cartPS = con.prepareStatement(
                "SELECT c.quantity, p.price, p.id FROM cart_items c JOIN products p ON c.product_id=p.id WHERE c.user_id=?"
            );
            cartPS.setInt(1, userId);
            ResultSet cartRS = cartPS.executeQuery();

            double total = 0;
            while (cartRS.next()) {
                total += cartRS.getInt("quantity") * cartRS.getDouble("price");
            }

            // Insert order
            PreparedStatement ps = con.prepareStatement(
                "INSERT INTO orders(user_id,total,status) VALUES(?,?,?)",
                Statement.RETURN_GENERATED_KEYS
            );
            ps.setInt(1, userId);
            ps.setDouble(2, total);
            ps.setString(3, "PLACED");
            ps.executeUpdate();

            ResultSet keys = ps.getGeneratedKeys();
            keys.next();
            int orderId = keys.getInt(1);

            // Re-execute cart query for inserting order items
            cartRS = cartPS.executeQuery();
            while (cartRS.next()) {
                PreparedStatement insertItem = con.prepareStatement(
                    "INSERT INTO order_items(order_id, product_id, quantity, price) VALUES(?,?,?,?)"
                );
                insertItem.setInt(1, orderId);
                insertItem.setInt(2, cartRS.getInt("id"));
                insertItem.setInt(3, cartRS.getInt("quantity"));
                insertItem.setDouble(4, cartRS.getDouble("price"));
                insertItem.executeUpdate();
            }

            // Clear cart
            PreparedStatement clear = con.prepareStatement(
                "DELETE FROM cart_items WHERE user_id=?"
            );
            clear.setInt(1, userId);
            clear.executeUpdate();

            con.commit();
            resp.sendRedirect("orderconformation.jsp"); // make sure this JSP exists

        } catch (Exception e) {
            e.printStackTrace();
            if (con != null) try { con.rollback(); } catch (SQLException ex) {}
            resp.sendRedirect("checkout.jsp?error=1");
        } finally {
            if (con != null) try { con.close(); } catch (SQLException ex) {}
        }
    }
}
