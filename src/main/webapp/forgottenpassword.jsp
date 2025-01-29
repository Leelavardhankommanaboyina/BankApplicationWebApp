<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Forgot Password</title>
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
        }
        .card {
            background-color: rgba(255, 255, 255, 0.1); /* Semi-transparent white background */
            border-radius: 10px;
            box-shadow: 0 0 30px rgba(0, 255, 255, 0.5); /* Cyan light effect */
            padding: 30px;
            width: 30%;
            color: #fff; /* White text color */
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
        .error {
            color: red;
            margin-top: 10px;
        }
    </style>
   
</head>
<body>
    <div class="card">
        <h2>Forgot Password</h2>
        <form action="SendOtpServlet" method="post" ">
            <div class="form-group">
                <label for="username">Username</label>
                <input type="text" id="username" name="username" required>
            </div>
            <div class="form-group">
                <button type="submit">Send OTP</button>
            </div>
            <div class="error">
                <%= request.getAttribute("error") != null ? request.getAttribute("error") : "" %>
            </div>
        </form>
    </div>
</body>
</html>
