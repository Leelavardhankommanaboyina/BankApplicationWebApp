<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Change Password</title>
    <style>
        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }

        @keyframes slideUp {
            from { transform: translateY(20px); }
            to { transform: translateY(0); }
        }

        body {
            font-family: Arial, sans-serif;
            background-color: black;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
            animation: fadeIn 1s ease-in-out;
        }

        .change-password-container {
            background-color: #2c2c2c;
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 0 20px 5px rgba(255, 105, 180, 0.6);
            text-align: center;
            width: 350px;
            animation: slideUp 0.5s ease-out;
        }

        .change-password-container h2 {
            margin-bottom: 20px;
            font-size: 28px;
            color: #ffffff;
            text-transform: uppercase;
            letter-spacing: 2px;
            position: relative;
        }

        .change-password-container h2::after {
            content: '';
            display: block;
            width: 50px;
            height: 2px;
            background-color: #ff69b4;
            margin: 10px auto 0;
        }

        .change-password-container input {
            width: calc(100% - 22px);
            padding: 12px;
            margin: 10px 0;
            border: 1px solid #555;
            border-radius: 5px;
            font-size: 16px;
            background-color: #3b3b3b;
            color: #fff;
        }

        .change-password-container button {
            padding: 12px 25px;
            font-size: 18px;
            border: none;
            border-radius: 5px;
            background-color: #ff69b4;
            color: white;
            cursor: pointer;
            transition: background-color 0.3s, transform 0.3s;
            margin-top: 10px;
        }

        .change-password-container button:hover {
            background-color: #ff4081;
            transform: translateY(-3px);
        }

        .message {
            font-size: 17px;
            color: green;
            margin-top: 15px;
        }
        .back-button {
            margin-top: 20px;
            padding: 10px 20px;
            background-color: #6c757d;
            color: #fff;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
            transition: background-color 0.3s;
        }
        .back-button:hover {
            background-color: #5a6268;
        }
    </style>
</head>
<body>
    <div class="change-password-container">
        <h2>Change Password</h2>
        <form action="ChangePasswordServlet" method="post">
            <input type="password" name="currentPassword" placeholder="Current Password" required>
            <input type="password" name="newPassword" placeholder="New Password" required>
            <input type="password" name="confirmPassword" placeholder="Confirm Password" required>
            <button type="submit">Change Password</button>
        </form>
        <% 
            String message = (String) request.getAttribute("message");
            if (message != null ) { 
        %>
            <div class="message"><%= message %></div>
        <% 
            } 
        %>
        <a href="customer-dashboard.jsp" class="back-button">Back</a>
    </div>
</body>
</html>
