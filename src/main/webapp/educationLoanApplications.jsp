<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="banking.EducationLoanApplication" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Education Loan Applications</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #F0F8FF; /* Alice Blue background */
            margin: 0;
            padding: 0;
        }
        .container {
            width: 80%;
            margin: 20px auto;
            background: rgba(255, 255, 255, 0.9); /* Slightly transparent background */
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
            border: 1px solid #ddd;
            padding: 12px;
            text-align: left;
        }
        table th {
            background-color: #87CEEB; /* Light blue color for table headers */
            color: #333;
        }
        table tbody tr:nth-child(even) {
            background-color: #f9f9f9; /* Alternate row color */
        }
        table tbody tr:hover {
            background-color: #1E90FF; /* Blue color on hover */
            color: #fff; /* White text color on hover */
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
        <h1>Education Loan Applications</h1>
        <a href="admin-dashboard.jsp" class="btn">Home</a>
        <form action="EducationLoanApplicationsServlet" method="post">
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Full Name</th>
                        <th>Contact Info</th>
                       
                        <th>Aadhaar Number</th>
                        <th>Academic Records</th>
                        <th>Admission Letter</th>
                        <th>Fee Structure</th>
                        <th>Entrance Exam Scores</th>
                       
                        <th>Loan Amount</th>
                        <th>Application Date</th>
                        
                    </tr>
                </thead>
                <tbody>
                    <%
                        List<EducationLoanApplication> applications = (List<EducationLoanApplication>) request.getAttribute("applications");
                        for (EducationLoanApplication app : applications) {
                    %>
                    <tr>
                        <td><%= app.getId() %></td>
                        <td><%= app.getFullName() %></td>
                        <td><%= app.getContactInfo() %></td>
                       
                       
                        <td><%= app.getAadhaarNumber() %></td>
                        <td><%= app.getAcademicRecords() %></td>
                        <td><%= app.getAdmissionLetter() %></td>
                        <td><%= app.getFeeStructure() %></td>
                        <td><%= app.getEntranceExamScores() %></td>
                       
                        
                        
                        <td><%= app.getLoanAmount() %></td>
                        <td><%= app.getApplicationDate() %></td>
                        
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
