<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Home - E-Commerce App</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            margin: 0;
            background: #f7f9fc;
            color: #333;
        }
        header {
            background: linear-gradient(90deg, #1d2671, #c33764);
            color: white;
            padding: 30px;
            text-align: center;
            box-shadow: 0 4px 12px rgba(0,0,0,0.2);
        }
        header h1 {
            margin: 0;
            font-size: 38px;
            font-weight: bold;
            letter-spacing: 1px;
        }
        nav {
            background: #ffffff;
            padding: 12px;
            text-align: center;
            position: sticky;
            top: 0;
            z-index: 10;
            box-shadow: 0 2px 6px rgba(0,0,0,0.1);
        }
        nav a {
            display: inline-block;
            background: linear-gradient(45deg, #3498db, #2ecc71);
            color: white;
            padding: 10px 20px;
            margin: 0 8px;
            text-decoration: none;
            border-radius: 30px;
            transition: all 0.3s ease;
            font-weight: 500;
        }
        nav a:hover {
            opacity: 0.9;
            transform: scale(1.08);
        }
        .hero {
            background: linear-gradient(to right, #6a11cb, #2575fc);
            color: white;
            text-align: center;
            padding: 80px 20px;
        }
        .hero h2 {
            font-size: 42px;
            margin-bottom: 15px;
        }
        .hero p {
            font-size: 18px;
            margin-bottom: 25px;
        }
        .hero a {
            background: #e67e22;
            padding: 12px 25px;
            color: white;
            border-radius: 25px;
            text-decoration: none;
            font-size: 18px;
            transition: 0.3s;
        }
        .hero a:hover {
            background: #d35400;
        }
        .container {
            padding: 50px 20px;
            text-align: center;
        }
        .welcome {
            font-size: 22px;
            margin-bottom: 20px;
        }
        .message {
            color: #27ae60;
            font-size: 18px;
            margin-bottom: 25px;
        }
        .products {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
            gap: 25px;
            margin-top: 30px;
        }
        .card {
            background: white;
            border-radius: 15px;
            padding: 25px;
            box-shadow: 0 6px 16px rgba(0,0,0,0.1);
            transition: all 0.3s ease;
        }
        .card:hover {
            transform: translateY(-10px);
            box-shadow: 0 10px 24px rgba(0,0,0,0.2);
        }
        .card h3 {
            margin: 10px 0;
            font-size: 22px;
            color: #2c3e50;
        }
        .card p {
            color: #555;
            font-size: 15px;
            margin-bottom: 15px;
        }
        .card button {
            background: linear-gradient(45deg, #e67e22, #f39c12);
            color: white;
            padding: 10px 18px;
            border: none;
            border-radius: 25px;
            cursor: pointer;
            font-weight: bold;
            transition: all 0.3s;
        }
        .card button:hover {
            transform: scale(1.1);
            background: linear-gradient(45deg, #d35400, #e67e22);
        }
        footer {
            background: #2c3e50;
            color: #ddd;
            padding: 20px;
            text-align: center;
            margin-top: 50px;
        }
    </style>
</head>
<body>

<header>
    <h1>🛒 E-Commerce App</h1>
</header>

<nav>
    <a href="products.jsp">🛍️ Products</a>
    <a href="cart.jsp">🛒 Cart</a>
    <a href="login.jsp">🔑 Login</a>
    <a href="register.jsp">📝 Register</a>
</nav>

<div class="hero">
    <h2>Welcome to Your Shopping Destination</h2>
    <p>Discover amazing deals and trending products every day!</p>
    <a href="products.jsp">Shop Now</a>
</div>

<div class="container">
    <%
        String user = (session != null) ? (String) session.getAttribute("user") : null;
        if (user != null) {
    %>
        <p class="welcome">👋 Hello, <b><%= user %></b>! You are logged in. 
            <a href="logout" style="color:red; text-decoration:none;">Logout</a>
        </p>
    <%
        }
    %>

    <p class="message">
        <%= request.getAttribute("message") != null ? request.getAttribute("message") : "" %>
    </p>

    <h2>✨ Featured Products</h2>
    <div class="products">
        <div class="card">
            <h3>Smartphone</h3>
            <p>Latest Android smartphone with high performance.</p>
            <button>Add to Cart</button>
        </div>
        <div class="card">
            <h3>Headphones</h3>
            <p>Noise-cancelling wireless headphones for music lovers.</p>
            <button>Add to Cart</button>
        </div>
        <div class="card">
            <h3>Wrist Watch</h3>
            <p>Stylish digital wrist watch with smart features.</p>
            <button>Add to Cart</button>
        </div>
    </div>
</div>

<footer>
    <p>&copy; 2025 E-Commerce App | Designed with ❤️ | All Rights Reserved</p>
</footer>

</body>
</html>
