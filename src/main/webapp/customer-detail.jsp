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
        <h1>Admin Dashboard</h1>
        <a href="admin-dashboard.jsp" class="btn">Home</a>

        <!-- Displaying Customer Table -->
        <h2>Customer Details</h2>
        <table>
            <thead>
                <tr>
                    <th>Customer ID</th>
                    <th>Username</th>
                    <th>Email</th>
                    
                    <th>Phone Number</th>
                    
                    <th>Age</th>
                    <th>Balance</th>
                    <th>Deposit</th>
                    <th>Withdraw</th>
                </tr>
            </thead>
            <tbody>
                <% 
                    List<Customer> customers = (List<Customer>) request.getAttribute("customers");
                    if (customers != null) {
                        for (Customer customer : customers) {
                %>
                <tr>
                    <td><%= customer.getCustomerId() %></td>
                    <td><%= customer.getUsername() %></td>
                    <td><%= customer.getEmail() %></td>
                    
                    <td><%= customer.getPhoneNumber() %></td>
                    
                    <td><%= customer.getAge() %></td>
                    <td><%= customer.getBalance() %></td>
                    <td>
                        <form action="deposit.jsp" method="get" style="display:inline;">
                            <input type="hidden" name="customerId" value="<%= customer.getCustomerId() %>">
                            <input type="submit" class="btn" value="Deposit">
                        </form>
                    </td>
                    <td>
                        <form action="withdraw.jsp" method="get" style="display:inline;">
                            <input type="hidden" name="customerId" value="<%= customer.getCustomerId() %>">
                            <input type="submit" class="btn" value="Withdraw">
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

