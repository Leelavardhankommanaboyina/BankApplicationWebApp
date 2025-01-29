<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Application For New Customer</title>
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
            background-color: #2c2c2c; /* Grey background */
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
            animation: fadeIn 1s ease-in-out;
        }

        .container {
            width: 40%; /* Reduced card size */
            background-color: #444; /* Darker grey */
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 0 20px 5px rgba(211, 211, 211, 0.5); /* Grey light effect */
            text-align: center;
            animation: slideUp 0.5s ease-out;
        }

        .container h2 {
            margin-bottom: 20px;
            font-size: 28px;
            color: #ffffff;
            text-transform: uppercase;
            letter-spacing: 2px;
            position: relative;
        }

        .container h2::after {
            content: '';
            display: block;
            width: 50px;
            height: 2px;
            background-color: #ccc; /* Light grey underline */
            margin: 10px auto 0;
        }

        .form-group {
            margin-bottom: 15px;
        }

        .form-group label {
            display: block;
            text-align: left;
            margin-bottom: 5px;
            color: #ffffff;
        }

        .form-group input {
            width: 100%;
            padding: 12px;
            box-sizing: border-box;
            border: 1px solid #555;
            border-radius: 5px;
            font-size: 16px;
            background-color: #555; /* Dark grey background */
            color: #fff;
        }

        .form-group button {
            padding: 12px 25px;
            font-size: 18px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s, transform 0.3s;
            margin-top: 10px;
            display: inline-block;
            margin-right: 10px;
        }

        .form-group .register-btn {
            background-color: #ffd700; /* Yellow */
            color: black;
        }

        .form-group .register-btn:hover {
            background-color: #ffc107; /* Darker yellow */
            transform: translateY(-3px);
        }

        .form-group .back-btn {
            background-color: #6c757d; /* Grey */
            color: white;
        }

        .form-group .back-btn:hover {
            background-color: #5a6268; /* Darker grey */
            transform: translateY(-3px);
        }

        .error-message {
            color: red;
            font-weight: bold;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Register New Customer</h2>
        <% if (request.getParameter("error") != null) { %>
            <p class="error-message"><%= request.getParameter("error") %></p>
        <% } %>
        <form action="RegisterServlet" method="post">
            <div class="form-group">
                <label for="username">Username</label>
                <input type="text" id="username" name="username" required>
            </div>
            <div class="form-group">
                <label for="password">Password</label>
                <input type="password" id="password" name="password" required>
            </div>
            <div class="form-group">
                <label for="email">Email</label>
                <input type="email" id="email" name="email" required>
            </div>
            <div class="form-group">
                <label for="full_name">Full Name</label>
                <input type="text" id="full_name" name="full_name" required>
            </div>
            <div class="form-group">
                <label for="phone_number">Phone Number</label>
                <input type="text" id="phone_number" name="phone_number" required>
            </div>
            <div class="form-group">
                <label for="address">Address</label>
                <input type="text" id="address" name="address" required>
            </div>
            <div class="form-group">
                <label for="age">Age</label>
                <input type="number" id="age" name="age" required>
            </div>
            <div class="form-group">
                <button type="submit" class="register-btn">Register</button>
                <button type="button" class="back-btn" onclick="window.location.href='index.jsp'">Back</button>
            </div>
        </form>
    </div>
</body>
</html>
