<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Customer Login</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: linear-gradient(135deg, #2c3e50, #000000); /* Dark gradient background */
            height: 100vh; /* Full height */
            margin: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            text-align: center;
            overflow: hidden;
        }
        .navbar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            background-color: rgba(0, 0, 0, 0.7);
            padding: 14px 20px;
            width: 100%;
            position: fixed;
            top: 0;
            z-index: 1000;
        }
        .navbar a {
            color: white;
            text-decoration: none;
            padding: 14px 20px;
            text-align: center;
            font-size: 18px;
            transition: background-color 0.3s;
        }
        .navbar a:hover {
            background-color: #0056b3;
        }
        .navbar a.active {
            background-color: #0056b3;
        }
        .card {
            background-color: rgba(255, 255, 255, 0.1); /* Semi-transparent white background */
            border-radius: 10px;
            box-shadow: 0 0 30px rgba(0, 255, 255, 0.5); /* Cyan light effect */
            margin-top: 80px; /* Adjusted for navbar */
            padding: 30px;
            width: 30%;
            text-align: center;
            color: #fff; /* White text color */
            position: relative;
            overflow: hidden;
            transition: transform 0.3s, box-shadow 0.3s; /* Animation for hover effect */
        }
        .card:hover {
            transform: translateY(-10px);
            box-shadow: 0 0 50px rgba(0, 255, 255, 0.7); /* Enhanced light effect on hover */
        }
        .form-group {
            margin-bottom: 15px;
        }
        .form-group label {
            display: block;
            text-align: left;
            margin-bottom: 5px;
            color: #ccc; /* Light grey text color */
        }
        .form-group input {
            width: 100%;
            padding: 10px;
            border: none;
            border-radius: 5px;
            background-color: rgba(255, 255, 255, 0.2); /* Light transparent input background */
            color: #fff;
            font-size: 16px;
        }
        .form-group input:focus {
            outline: none;
            box-shadow: 0 0 5px rgba(0, 255, 255, 0.5); /* Light effect on focus */
        }
        .form-group button {
            padding: 10px 20px;
            background-color: #007bff;
            color: #fff;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 18px;
            transition: background-color 0.3s;
        }
        .form-group button:hover {
            background-color: #0056b3;
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
        .forgot-password {
            margin-top: 10px;
            color: #007bff;
            text-decoration: none;
            font-size: 14px;
            display: block;
            transition: color 0.3s;
        }
        .forgot-password:hover {
            color: #0056b3;
        }
        .error-message {
            color: red;
            font-size: 14px;
            margin-top: 10px;
        }
    </style>
</head>
<body>
    <div class="card">
        <h2>Customer Login</h2>
        <form action="CustomerLoginServlet" method="post">
            <div class="form-group">
                <label for="username">Username</label>
                <input type="text" id="username" name="username" required>
            </div>
            <div class="form-group">
                <label for="password">Password</label>
                <input type="password" id="password" name="password" required>
            </div>
            <!-- Check if there's an error message attribute and display it -->
            <%
                String errorMessage = (String) request.getAttribute("errorMessage");
                if (errorMessage != null) {
            %>
                <div class="error-message"><%= errorMessage %></div>
            <%
                }
            %>
            <div class="form-group">
                <button type="submit">Login</button>
            </div>
        </form>
        <a href="forgottenpassword.jsp" class="forgot-password">Forgotten Password?</a>
        <a href="index.jsp" class="back-button">Back</a>
    </div>
</body>
</html>