<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*, util.DBConnection" %>
<%@ page session="true" %>
<%
    Object userIdObj = session.getAttribute("userId");
    if(userIdObj == null){
        response.sendRedirect("login.jsp");
        return; // stop further execution
    }
%>
<html>
<head>
    <title>Products</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f7f9fc;
            margin: 0;
            padding: 0;
        }
        header {
            background: #4CAF50;
            padding: 15px;
            text-align: center;
        }
        header h2 { color: white; margin: 0; }
        nav { margin: 10px; text-align: center; }
        nav a {
            text-decoration: none;
            margin: 0 15px;
            color: #4CAF50;
            font-weight: bold;
        }
        table {
            width: 90%;
            margin: 20px auto;
            border-collapse: collapse;
            background: white;
            box-shadow: 0px 4px 10px rgba(0,0,0,0.1);
            border-radius: 10px;
            overflow: hidden;
        }
        th, td {
            padding: 12px 15px;
            text-align: center;
            border-bottom: 1px solid #ddd;
        }
        th { background: #4CAF50; color: white; }
        tr:hover { background: #f1f1f1; }
        input[type="number"] {
            width: 60px;
            padding: 5px;
            border: 1px solid #ccc;
            border-radius: 6px;
        }
        input[type="submit"] {
            background: #4CAF50;
            color: white;
            border: none;
            padding: 6px 12px;
            border-radius: 6px;
            cursor: pointer;
        }
        input[type="submit"]:hover { background: #45a049; }
        footer {
            margin-top: 20px;
            text-align: center;
            padding: 15px;
            background: #eee;
        }
    </style>
</head>
<body>
    <header>
        <h2>Available Products</h2>
    </header>

    <nav>
        <a href="cart.jsp">🛒 View Cart</a>
        <a href="index.jsp">🏠 Home</a>
    </nav>

    <table>
        <tr>
            <th>Name</th>
            <th>Description</th>
            <th>Price (₹)</th>
            <th>Stock</th>
            <th>Action</th>
        </tr>
        <%
            try (Connection con = DBConnection.getConnection()) {
                PreparedStatement ps = con.prepareStatement("SELECT * FROM products");
                ResultSet rs = ps.executeQuery();
                while (rs.next()) {
        %>
        <tr>
            <td><%= rs.getString("name") %></td>
            <td><%= rs.getString("description") %></td>
            <td>₹<%= rs.getDouble("price") %></td>
            <td><%= rs.getInt("stock") %></td>
            <td>
                <form action="CartServlet" method="post">
                    <input type="hidden" name="productId" value="<%= rs.getInt("id") %>">
                    <input type="number" name="quantity" value="1" min="1" max="<%= rs.getInt("stock") %>">
                    <input type="submit" value="Add to Cart">
                </form>
            </td>
        </tr>
        <%
                }
            } catch(Exception e){ out.println("<tr><td colspan='5'>Error: " + e + "</td></tr>"); }
        %>
    </table>

    <footer>
        <p>&copy; 2025 E-Commerce Application</p>
    </footer>
</body>
</html>
