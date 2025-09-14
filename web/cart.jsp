<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.sql.*, util.DBConnection" %>
<%@ page session="true" %>
<html>
<head>
    <title>My Cart</title>
    <style>
        body { font-family: Arial, sans-serif; background: #f7f9fc; margin: 0; padding: 0; }
        header { background: #4CAF50; padding: 15px; text-align: center; position: relative; }
        header h2 { color: white; margin: 0; }
        header a.logout {
            position: absolute; right: 20px; top: 15px;
            color: white; font-weight: bold; text-decoration: none;
            background: #e53935; padding: 6px 12px; border-radius: 5px;
        }
        header a.logout:hover { background: #c62828; }
        table {
            width: 80%; margin: 20px auto; border-collapse: collapse;
            background: white; box-shadow: 0px 4px 10px rgba(0,0,0,0.1);
            border-radius: 10px; overflow: hidden;
        }
        th, td { padding: 12px 15px; text-align: center; border-bottom: 1px solid #ddd; }
        th { background: #4CAF50; color: white; }
        tr:hover { background: #f1f1f1; }
        .grand-total { font-weight: bold; background: #f9f9f9; }
        .btn {
            display: inline-block; padding: 8px 15px; background: #4CAF50;
            color: white; text-decoration: none; border-radius: 6px;
            margin: 15px auto; text-align: center;
        }
        .btn:hover { background: #45a049; }
        input[type="submit"] {
            padding: 5px 10px; background-color: #f44336; color: white;
            border: none; border-radius: 5px; cursor: pointer;
        }
        input[type="submit"]:hover { background-color: #d32f2f; }
        .message { text-align:center; margin:15px; font-weight:bold; }
        .success { color: green; }
        .error { color: red; }
        footer { margin-top: 30px; text-align: center; padding: 15px; background: #eee; }
    </style>
</head>
<body>

<header>
    <h2>🛒 Your Cart</h2>
    <!-- ✅ Logout button -->
    <a href="${pageContext.request.contextPath}/logout" class="logout">🔒 Logout</a>
</header>

<!-- ✅ Success / Error messages -->
<%
    String removed = request.getParameter("removed");
    String error = request.getParameter("error");
    if ("1".equals(removed)) {
%>
    <div class="message success">✅ Item removed successfully!</div>
<%
    } else if ("1".equals(error)) {
%>
    <div class="message error">❌ Failed to remove item. Please try again.</div>
<%
    }
%>

<%
    Object userIdObj = session.getAttribute("userId");
    if(userIdObj == null){
        response.sendRedirect("login.jsp");
        return;
    }
    int userId = Integer.parseInt(userIdObj.toString());

    try (Connection con = DBConnection.getConnection()) {
        PreparedStatement ps = con.prepareStatement(
            "SELECT c.product_id, p.name, p.price, c.quantity " +
            "FROM cart_items c JOIN products p ON c.product_id = p.id " +
            "WHERE c.user_id=?"
        );
        ps.setInt(1, userId);
        ResultSet rs = ps.executeQuery();
%>

<table>
    <tr>
        <th>Product</th>
        <th>Price (₹)</th>
        <th>Quantity</th>
        <th>Total (₹)</th>
        <th>Action</th>
    </tr>
<%
        double grandTotal = 0;
        boolean hasItems = false;
        while(rs.next()){
            hasItems = true;
            int productId = rs.getInt("product_id");
            String name = rs.getString("name");
            double price = rs.getDouble("price");
            int qty = rs.getInt("quantity");
            double total = price * qty;
            grandTotal += total;
%>
    <tr>
        <td><%= name %></td>
        <td>₹<%= price %></td>
        <td><%= qty %></td>
        <td>₹<%= total %></td>
        <td>
            <form action="${pageContext.request.contextPath}/RemoveFromServlet" method="post">
                <input type="hidden" name="productId" value="<%= productId %>">
                <input type="submit" value="Remove">
            </form>
        </td>
    </tr>
<%
        }
        if(!hasItems){
%>
    <tr><td colspan="5">Your cart is empty!</td></tr>
<%
        } else {
%>
    <tr class="grand-total">
        <td colspan="4">Grand Total</td>
        <td>₹<%= grandTotal %></td>
    </tr>
<%
        }
%>
</table>

<div style="text-align: center;">
    <a href="products.jsp" class="btn">Continue Shopping</a>
    <% if(hasItems){ %>
    <a href="checkout.jsp" class="btn">Proceed to Checkout</a>
    <% } %>
</div>

<footer>
    <p>&copy; 2025 E-Commerce Application</p>
</footer>

<%
    } catch(Exception e){
        out.println("<p style='color:red; text-align:center;'>Error: " + e + "</p>");
    }
%>

</body>
</html>
