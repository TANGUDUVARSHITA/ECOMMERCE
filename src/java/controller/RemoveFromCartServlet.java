package controller;

import util.DBConnection;
import java.io.IOException;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.sql.*;

@WebServlet("/RemoveFromServlet")
public class RemoveFromCartServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            // Redirect to login if session does not exist
            resp.sendRedirect("login.jsp");
            return;
        }

        int userId = (int) session.getAttribute("userId");
        int productId = Integer.parseInt(req.getParameter("productId"));

        try (Connection con = DBConnection.getConnection()) {
            PreparedStatement ps = con.prepareStatement(
                "DELETE FROM cart_items WHERE user_id=? AND product_id=?"
            );
            ps.setInt(1, userId);
            ps.setInt(2, productId);
            ps.executeUpdate();

            // Redirect with success flag
            resp.sendRedirect("cart.jsp?removed=1");

        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect("cart.jsp?error=1");
        }
    }
}
