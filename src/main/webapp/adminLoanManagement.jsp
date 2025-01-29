<%@ page import="java.sql.*, java.util.*" %>
<%
    // Database connection
    Connection con = null;
    PreparedStatement pst = null;
    ResultSet rs = null;
    List<Map<String, String>> loanApplications = new ArrayList<>();

    try {
        Class.forName("com.mysql.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/bankdb", "root", "Layavardhan@2003");

        // Fetch only loan applications with status 'pending' from all tables with usernames
        String combinedSQL = "SELECT c.username, 'Personal Loan' AS loanType, p.customer_id, p.loanAmount, p.loanTenure, p.status, p.application_date "
                            + "FROM personal_loan_applications p "
                            + "JOIN customer c ON p.customer_id = c.customer_id "
                            + "WHERE p.status = 'pending' "
                            + "UNION ALL "
                            + "SELECT c.username, 'Vehicle Loan' AS loanType, v.customer_id, v.loanAmount, v.loanTenure, v.status, v.application_date "
                            + "FROM vehicle_loan_applications v "
                            + "JOIN customer c ON v.customer_id = c.customer_id "
                            + "WHERE v.status = 'pending' "
                            + "UNION ALL "
                            + "SELECT c.username, 'Home Loan' AS loanType, h.customer_id, h.loanAmount, h.loanTenure, h.status, h.application_date "
                            + "FROM home_loan_applications h "
                            + "JOIN customer c ON h.customer_id = c.customer_id "
                            + "WHERE h.status = 'pending' "
                            + "UNION ALL "
                            + "SELECT c.username, 'Education Loan' AS loanType, e.customer_id, e.loanAmount, e.loanTenure, e.status, e.application_date "
                            + "FROM education_loan_applications e "
                            + "JOIN customer c ON e.customer_id = c.customer_id "
                            + "WHERE e.status = 'pending'";

        pst = con.prepareStatement(combinedSQL);
        rs = pst.executeQuery();

        while (rs.next()) {
            Map<String, String> loanApplication = new HashMap<>();
           
            loanApplication.put("customer_id", rs.getString("customer_id"));
            loanApplication.put("username", rs.getString("username"));
            loanApplication.put("loanType", rs.getString("loanType"));
            loanApplication.put("loanAmount", rs.getString("loanAmount"));
            loanApplication.put("loanTenure", rs.getString("loanTenure"));
            loanApplication.put("application_date", rs.getString("application_date"));
            loanApplication.put("status", rs.getString("status"));
            loanApplications.add(loanApplication);
        }
    } catch (Exception e) {
        e.printStackTrace();
        out.println("Error: " + e.getMessage());
    } finally {
        try { if (rs != null) rs.close(); } catch (SQLException e) { e.printStackTrace(); }
        try { if (pst != null) pst.close(); } catch (SQLException e) { e.printStackTrace(); }
        try { if (con != null) con.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
%>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin Loan Management</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 75vh;
            animation: fadeIn 2s ease-in-out;
        }
        .container {
            width: 80%;
            max-width: 1200px;
            margin: 0 auto;
        }
        h2 {
            text-align: center;
            margin-bottom: 20px;
            padding: 10px;
            background-color: #007bff;
            color: white;
            border-radius: 4px;
            font-size: 24px;
            animation: fadeIn 2s ease-in-out;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            background: #fff;
            box-shadow: 0 2px 3px rgba(0,0,0,0.1);
            animation: scaleIn 0.5s ease-in-out;
            margin-bottom: 20px;
        }
        th, td {
            padding: 12px;
            border: 1px solid #dee2e6;
            text-align: left;
            transition: background-color 0.3s ease;
        }
        th {
            background-color: #f8f9fa;
            font-weight: bold;
            border-bottom: 2px solid #007bff;
        }
        tr:nth-child(even) {
            background-color: #f9f9f9;
        }
        tr:nth-child(odd) {
            background-color: #fff;
        }
        tr:hover {
            background-color: #e0f7fa;
            transform: translateY(-5px);
            transition: background-color 0.3s ease, transform 0.3s ease;
        }
        .action-buttons {
            display: flex;
            gap: 10px;
        }
        .approve-btn, .reject-btn {
            padding: 5px 10px;
            border: none;
            cursor: pointer;
            border-radius: 4px;
            font-size: 14px;
            transition: transform 0.2s ease, box-shadow 0.2s ease;
        }
        .approve-btn {
            background-color: #28a745;
            color: white;
        }
        .approve-btn:hover {
            background-color: #218838;
            transform: scale(1.05);
            box-shadow: 0 4px 8px rgba(0,0,0,0.2);
        }
        .reject-btn {
            background-color: #dc3545;
            color: white;
        }
        .reject-btn:hover {
            background-color: #c82333;
            transform: scale(1.05);
            box-shadow: 0 4px 8px rgba(0,0,0,0.2);
        }
        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }
        @keyframes scaleIn {
            from { transform: scale(0.95); opacity: 0; }
            to { transform: scale(1); opacity: 1; }
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Admin Loan Management</h2>
        <table>
            <thead>
                <tr>
                    <th>Customer ID</th>
                    <th>Username</th>
                    <th>Loan Type</th>
                    <th>Loan Amount</th>
                    <th>Loan Tenure</th>
                    <th>Application Date</th>
                    <th>Status</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <% if (loanApplications.isEmpty()) { %>
                    <tr>
                        <td colspan="8">No loan applications found.</td>
                    </tr>
                <% } else {
                    for (Map<String, String> loanApplication : loanApplications) { %>
                    <tr>
                        <td><%= loanApplication.get("customer_id") %></td>
                        <td><%= loanApplication.get("username") %></td>
                        <td><%= loanApplication.get("loanType") %></td>
                        <td><%= loanApplication.get("loanAmount") %></td>
                        <td><%= loanApplication.get("loanTenure") %></td>
                        <td><%= loanApplication.get("application_date") %></td>
                        <td><%= loanApplication.get("status") %></td>
                        <td class="action-buttons">
                            <form action="LoanApprovalServlet" method="post" style="display:inline;">
                                <input type="hidden" name="customer_id" value="<%= loanApplication.get("customer_id") %>">
                                <input type="hidden" name="loanType" value="<%= loanApplication.get("loanType") %>">
                                <input type="hidden" name="application_date" value="<%= loanApplication.get("application_date") %>">
                                <button type="submit" name="action" value="approve" class="approve-btn">Approve</button>
                            </form>
                            <form action="LoanApprovalServlet" method="post" style="display:inline;">
                                <input type="hidden" name="customer_id" value="<%= loanApplication.get("customer_id") %>">
                                <input type="hidden" name="loanType" value="<%= loanApplication.get("loanType") %>">
                                <input type="hidden" name="application_date" value="<%= loanApplication.get("application_date") %>">
                                <button type="submit" name="action" value="reject" class="reject-btn">Reject</button>
                            </form>
                        </td>
                    </tr>
                    <% }
                } %>
            </tbody>
        </table>
    </div>
</body>
</html>
