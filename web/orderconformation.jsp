<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Order Confirmation</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f7f7f7;
            margin: 0;
            padding: 0;
        }
        .confirmation-container {
            max-width: 500px;
            margin: 100px auto;
            background-color: #ffffff;
            padding: 30px 40px;
            border-radius: 10px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.2);
            text-align: center;
        }
        h2 {
            color: #4CAF50;
            margin-bottom: 20px;
        }
        p {
            font-size: 16px;
        }
        a {
            display: inline-block;
            margin-top: 20px;
            padding: 10px 20px;
            background-color: #4CAF50;
            color: white;
            text-decoration: none;
            border-radius: 6px;
        }
        a:hover { background-color: #45a049; }
    </style>
</head>
<body>
    <div class="confirmation-container">
        <h2>Order Placed Successfully!</h2>
        <p>Thank you for your purchase. Your order has been placed.</p>
        <a href="index.jsp">Continue Shopping</a>
    </div>
</body>
</html>
