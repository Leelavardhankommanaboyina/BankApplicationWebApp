<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="banking.Transaction" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Transaction History</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #87CEEB; /* Light blue background */
            margin: 0;
            padding: 0;
        }
        .container {
            width: 80%;
            margin: 20px auto;
            background: rgba(255, 255, 255, 0.8); /* Transparent background */
            padding: 20px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
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
        table th, table td {
            border: none; /* Remove border lines */
            padding: 12px;
            text-align: left;
        }
        table th {
            background-color: #ADD8E6; /* Light blue color for table headers */
            color: #333;
        }
        table tbody tr:nth-child(even) {
            background-color: #f9f9f9; /* Alternate row color */
        }
        table tbody tr:hover {
            background-color: #1E90FF; /* Blue color on hover */
            color: #fff; /* White text color on hover */
            transform: scale(1.05); /* Scale up the row */
            transition: transform 0.2s ease-out, background-color 0.2s ease-out, box-shadow 0.2s ease-out; /* Smooth transition */
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.2); /* Add shadow on hover */
            z-index: 1; /* Ensure it's above other rows */
        }
        table tbody tr {
            transition: transform 0.2s ease-out, background-color 0.2s ease-out; /* Smooth transition for non-hovered rows */
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
            background-color: #4CAF50;
            border: none;
            border-radius: 15px;
            box-shadow: 0 5px #999;
            margin: 10px 0;
        }
        .btn:hover {
            background-color: #45a049;
        }
        .btn:active {
            background-color: #45a049;
            box-shadow: 0 2px #666;
            transform: translateY(2px);
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Transaction History</h1>
        <a href="customer-dashboard.jsp" class="btn">Back to Dashboard</a>

        <!-- Displaying Transaction History Table -->
        <h2>Transactions in Bank </h2>
        <table>
            <thead>
                <tr>
                    <th>Transaction ID</th>
                    <th>Transaction Time</th>
                    <th>Transaction Type</th>
                    <th>Amount</th>
                    <th>Balance</th>
                </tr>
            </thead>
            <tbody>
                <% 
                    List<Transaction> transactionList = (List<Transaction>) request.getAttribute("transactionList");
                    if (transactionList != null) {
                        for (Transaction transaction : transactionList) {
                %>
                <tr>
                    <td><%= transaction.getTransactionId() %></td>
                    <td><%= transaction.getTransactionTime() %></td>
                    <td><%= transaction.getTransactionType() %></td>
                    <td><%= transaction.getAmount() %></td>
                    <td><%= transaction.getBalance() %></td>
                </tr>
                <% 
                        }
                    }
                %>
            </tbody>
        </table>

        <!-- Displaying Transactions From Table -->
        <h2>Transactions To</h2>
        <table>
            <thead>
                <tr>
                    <th>Transaction ID</th>
                    <th>Transaction Time</th>
                    <th>Transaction Type</th>
                    <th>Amount</th>
                    
                    <th>To User</th>
                </tr>
            </thead>
            <tbody>
                <% 
                    List<Transaction> transactionFromList = (List<Transaction>) request.getAttribute("transactionFromList");
                    if (transactionFromList != null) {
                        for (Transaction transaction : transactionFromList) {
                %>
                <tr>
                    <td><%= transaction.getTransactionId() %></td>
                    <td><%= transaction.getTransactionTime() %></td>
                    <td><%= transaction.getTransactionType() %></td>
                    <td><%= transaction.getAmount() %></td>
                    
                    <td><%= transaction.getToUser() %></td>
                </tr>
                <% 
                        }
                    }
                %>
            </tbody>
        </table>

        <!-- Displaying Transactions From Account Table -->
        <h2>Transactions From </h2>
        <table>
            <thead>
                <tr>
                    <th>Transaction ID</th>
                    <th>Transaction Time</th>
                    <th>Transaction Type</th>
                    <th>Amount</th>
                    
                    <th>From User</th>
                </tr>
            </thead>
            <tbody>
                <% 
                    List<Transaction> transactionFromAccountList = (List<Transaction>) request.getAttribute("transactionFromAccountList");
                    if (transactionFromAccountList != null) {
                        for (Transaction transaction : transactionFromAccountList) {
                %>
                <tr>
                    <td><%= transaction.getTransactionId() %></td>
                    <td><%= transaction.getTransactionTime() %></td>
                    <td><%= transaction.getTransactionType() %></td>
                    <td><%= transaction.getAmount() %></td>
                    
                    <td><%= transaction.getToUser() %></td>
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
