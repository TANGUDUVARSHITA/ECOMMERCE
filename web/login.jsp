<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Login - E-Commerce App</title>
    <style>
        body {
            font-family: 'Segoe UI', Arial, sans-serif;
            background: linear-gradient(135deg, #00c6ff, #0072ff);
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .login-container {
            background: #fff;
            padding: 40px;
            border-radius: 14px;
            box-shadow: 0 8px 24px rgba(0,0,0,0.2);
            width: 350px;
            text-align: center;
            animation: fadeIn 0.8s ease-in-out;
        }
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        .login-container h2 {
            margin-bottom: 20px;
            color: #2c3e50;
        }
        .login-container form {
            display: flex;
            flex-direction: column;
        }
        .login-container input[type="email"],
        .login-container input[type="password"] {
            padding: 12px;
            margin: 10px 0;
            border: 1px solid #ddd;
            border-radius: 8px;
            outline: none;
            font-size: 14px;
            transition: all 0.3s;
        }
        .login-container input:focus {
            border-color: #0072ff;
            box-shadow: 0 0 6px rgba(0,114,255,0.4);
        }
        .login-container input[type="submit"] {
            background: #0072ff;
            color: white;
            border: none;
            padding: 12px;
            border-radius: 8px;
            cursor: pointer;
            font-size: 15px;
            font-weight: bold;
            margin-top: 15px;
            transition: background 0.3s, transform 0.2s;
        }
        .login-container input[type="submit"]:hover {
            background: #0056cc;
            transform: scale(1.03);
        }
        .message {
            color: red;
            margin-top: 15px;
            font-size: 14px;
        }
        .success {
            color: green;
            margin-top: 15px;
            font-size: 14px;
            font-weight: bold;
        }
        .extra-links {
            margin-top: 15px;
            font-size: 14px;
        }
        .extra-links a {
            text-decoration: none;
            color: #0072ff;
            font-weight: bold;
        }
        .extra-links a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>

<div class="login-container">
    <h2>🔑 Login</h2>
    <form action="login" method="post">
        <input type="email" name="email" placeholder="Email Address" required>
        <input type="password" name="password" placeholder="Password" required>
        <input type="submit" value="Login">
    </form>

    <!-- Error message from login -->
    <p class="message">
        <%= request.getAttribute("message") != null ? request.getAttribute("message") : "" %>
    </p>

    <!-- Success message (for logout) -->
    <%
        String successMsg = request.getParameter("message");
        if (successMsg != null) {
    %>
        <p class="success"><%= successMsg %></p>
    <%
        }
    %>

    <div class="extra-links">
        <p>Don’t have an account? <a href="register.jsp">Register</a></p>
    </div>
</div>

</body>
</html>
