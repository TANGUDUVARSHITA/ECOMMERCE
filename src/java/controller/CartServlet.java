package controller;

import util.DBConnection;
import java.io.IOException;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;

@WebServlet("/CartServlet")
public class CartServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false); // do NOT create new session
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int userId = (int) session.getAttribute("userId");

        String productIdParam = request.getParameter("productId");
        String quantityParam = request.getParameter("quantity");

        if (productIdParam == null || quantityParam == null) {
            response.getWriter().println("Missing productId or quantity.");
            return;
        }

        try {
            int productId = Integer.parseInt(productIdParam);
            int quantity = Integer.parseInt(quantityParam);

            try (Connection con = DBConnection.getConnection()) {
                PreparedStatement ps = con.prepareStatement(
                    "INSERT INTO cart_items(user_id, product_id, quantity) " +
                    "VALUES(?, ?, ?) " +
                    "ON DUPLICATE KEY UPDATE quantity = quantity + VALUES(quantity)"
                );
                ps.setInt(1, userId);
                ps.setInt(2, productId);
                ps.setInt(3, quantity);

                ps.executeUpdate();

                // Redirect to cart.jsp after adding product
                response.sendRedirect("cart.jsp?added=1");
            }

        } catch (NumberFormatException nfe) {
            response.getWriter().println("Invalid productId or quantity format.");
            nfe.printStackTrace();
        } catch (SQLException sqle) {
            response.getWriter().println("Database error: " + sqle.getMessage());
            sqle.printStackTrace();
        } catch (Exception e) {
            response.getWriter().println("Unexpected error: " + e.getMessage());
            e.printStackTrace();
        }
    }
}
