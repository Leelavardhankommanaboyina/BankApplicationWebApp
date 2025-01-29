<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="banking.Customer" %>
<%@ page import="banking.Register" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f0f0;
            margin: 0;
            padding: 0;
        }
        .container {
            width: 80%;
            margin: 20px auto;
            background: rgba(255, 255, 255, 0.8); /* Transparent background */
            padding: 20px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            transition: transform 0.5s ease-in-out, box-shadow 0.5s ease-in-out; /* 3D animation */
        }
        h1 {
            text-align: center;
            color: #333;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            padding: 12px;
            text-align: left;
        }
        th {
            background-color: #add8e6; /* Light blue color for table heading */
        }
        tr:nth-child(even) {
            background-color: #f9f9f9;
        }
        tr:hover {
            background-color: #87cefa; /* Blue color for row on hover */
            transform: scale(1.05); /* Pop-up effect */
            transition: transform 0.2s ease-out; /* Smooth transition */
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.2); /* Add shadow on hover */
        }
        .btn {
            display: inline-block;
            padding: 10px 20px;
            font-size: 14px;
            cursor: pointer;
            text-align: center;
            text-decoration: none;
            outline: none;
            color: #fff;
            background-color: #add8e6; /* Light blue color for button */
            border: none;
            border-radius: 15px;
            box-shadow: 0 5px #999;
            margin: 5px;
        }
        .btn:hover {
            background-color: #87ceeb;
        }
        .btn:active {
            background-color: #87ceeb;
            box-shadow: 0 2px #666;
            transform: translateY(2px);
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>NEW BANK APPLICATIONS</h1>
        <a href="admin-dashboard.jsp" class="btn">Home</a>

       
        <!-- Displaying Register Table -->
        <h2>Applications For New Account</h2>
        <table>
            <thead>
                <tr>
                    <th>Username</th>
                    <th>Email</th>
                    <th>Full Name</th>
                    <th>Phone Number</th>
                    <th>Address</th>
                    <th>Age</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <% 
                    List<Register> registers = (List<Register>) request.getAttribute("registers");
                    if (registers != null) {
                        for (Register register : registers) {
                %>
                <tr>
                    <td><%= register.getUsername() %></td>
                    <td><%= register.getEmail() %></td>
                    <td><%= register.getFullName() %></td>
                    <td><%= register.getPhoneNumber() %></td>
                    <td><%= register.getAddress() %></td>
                    <td><%= register.getAge() %></td>
                    <td>
                        <form action="AdminDashboardServlet" method="post">
                            <input type="hidden" name="username" value="<%= register.getUsername() %>">
                            <input type="submit" class="btn accept" name="accept" value="Accept">
                            <input type="submit" class="btn reject" name="reject" value="Reject">
                        </form>
                    </td>
                </tr>
                <% 
                        }
                    }
                %>
            </tbody>
        </table>
    </div>
</body>
</html>