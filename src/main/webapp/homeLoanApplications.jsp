<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="banking.HomeLoanApplication" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Home Loan Applications</title>
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
        <h1>Home Loan Applications</h1>
        <a href="admin-dashboard.jsp" class="btn">Home</a>
        <!-- Displaying Home Loan Applications Table -->
        <form action="HomeLoanApplicationsServlet" method="post">
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Full Name</th>
                        <th>PAN Card</th>
                        <th>Aadhaar Card</th>
                        <th>Contact Number</th>
                        <th>Occupation</th>
                        <th>Monthly Income</th>
                        <th>Property Address</th>
                        <th>Property Type</th>
                        <th>Property Value</th>
                        <th>Loan Amount</th>
                        <th>Loan Tenure</th>
                        
                    </tr>
                </thead>
                <tbody>
                    <%
                        List<HomeLoanApplication> applicationsList = (List<HomeLoanApplication>) request.getAttribute("applications");
                        for (HomeLoanApplication loanApp : applicationsList) {
                    %>
                    <tr>
                        <td><%= loanApp.getId() %></td>
                        <td><%= loanApp.getFullName() %></td>
                        <td><%= loanApp.getPanCard() %></td>
                        <td><%= loanApp.getAadhaarCard() %></td>
                        <td><%= loanApp.getContactNumber() %></td>
                        <td><%= loanApp.getOccupation() %></td>
                        <td><%= loanApp.getMonthlyIncome() %></td>
                        <td><%= loanApp.getPropertyAddress() %></td>
                        <td><%= loanApp.getPropertyType() %></td>
                        <td><%= loanApp.getPropertyValue() %></td>
                        <td><%= loanApp.getLoanAmount() %></td>
                        <td><%= loanApp.getLoanTenure() %></td>
                        
                    </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
        </form>
    </div>
</body>
</html>
