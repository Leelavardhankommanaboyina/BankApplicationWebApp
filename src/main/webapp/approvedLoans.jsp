<%@ page import="java.sql.*, java.util.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Approved Loan Applications</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            flex-direction: column;
            min-height: 100vh;
            overflow: hidden;
            background: linear-gradient(135deg, #f3f4f6, #dcdbe1);
        }
        .container {
            width: 80%;
            background: white;
            padding: 20px;
            box-shadow: 0 0 15px rgba(0,0,0,0.2);
            border-radius: 10px;
            animation: fadeIn 1s ease-in;
        }
        h1 {
            text-align: center;
            color: #333;
            margin-bottom: 20px;
        }
        .search-bar {
            margin-bottom: 20px;
            text-align: center;
        }
        .search-bar input[type="text"] {
            width: 22%;
            padding: 10px;
            border-radius: 5px;
            border: 1px solid #ccc;
            transition: border-color 0.3s;
        }
        .search-bar input[type="text"]:focus {
            border-color: #28a745;
            outline: none;
        }
        .search-bar input[type="submit"] {
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            background-color: #28a745;
            color: white;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        .search-bar input[type="submit"]:hover {
            background-color: #218838;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            animation: slideIn 1s ease-in;
        }
        table, th, td {
            border: 1px solid #ccc;
        }
        th, td {
            padding: 10px;
            text-align: center;
            transition: background-color 0.3s, color 0.3s;
        }
        th {
            background-color: #f2f2f2;
        }
        tr:nth-child(even) {
            background-color: #f9f9f9;
        }
        tr:hover {
            background-color: #e2e6ea;
        }
        .no-loans-message {
            text-align: center;
            color: red;
            margin-top: 20px;
        }
        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }
        @keyframes slideIn {
            from { transform: translateY(-20px); opacity: 0; }
            to { transform: translateY(0); opacity: 1; }
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Approved Loan Applications</h1>

        <div class="search-bar">
            <form method="get" action="approvedLoans.jsp">
                <input type="text" name="search" placeholder="Enter username or customer ID to search...">
                <input type="submit" value="Search">
            </form>
        </div>

        <%
            // Database connection
            Connection con = null;
            PreparedStatement pst = null;
            ResultSet rs = null;
            String searchParam = request.getParameter("search");
            boolean hasLoans = false;

            try {
                Class.forName("com.mysql.jdbc.Driver");
                con = DriverManager.getConnection("jdbc:mysql://localhost:3306/bankdb", "root", "Layavardhan@2003");

                String combinedSQL = "";
                if (searchParam != null && !searchParam.isEmpty()) {
                    // Determine if the search parameter is a number (customer_id) or a string (username)
                    if (searchParam.matches("\\d+")) {  // If searchParam is a number
                        int customerId = Integer.parseInt(searchParam);

                        combinedSQL = "SELECT c.username, 'Personal Loan' AS loanType, a.customer_id, a.loanAmount, a.loanTenure, a.status FROM personal_loan_applications a "
                                    + "JOIN customer c ON a.customer_id = c.customer_id WHERE a.customer_id = ? AND a.status = 'Approved' "
                                    + "UNION ALL "
                                    + "SELECT c.username, 'Vehicle Loan' AS loanType, a.customer_id, a.loanAmount, a.loanTenure, a.status FROM vehicle_loan_applications a "
                                    + "JOIN customer c ON a.customer_id = c.customer_id WHERE a.customer_id = ? AND a.status = 'Approved' "
                                    + "UNION ALL "
                                    + "SELECT c.username, 'Home Loan' AS loanType, a.customer_id, a.loanAmount, a.loanTenure, a.status FROM home_loan_applications a "
                                    + "JOIN customer c ON a.customer_id = c.customer_id WHERE a.customer_id = ? AND a.status = 'Approved' "
                                    + "UNION ALL "
                                    + "SELECT c.username, 'Education Loan' AS loanType, a.customer_id, a.loanAmount, a.loanTenure, a.status FROM education_loan_applications a "
                                    + "JOIN customer c ON a.customer_id = c.customer_id WHERE a.customer_id = ? AND a.status = 'Approved'";
                        pst = con.prepareStatement(combinedSQL);
                        pst.setInt(1, customerId);
                        pst.setInt(2, customerId);
                        pst.setInt(3, customerId);
                        pst.setInt(4, customerId);
                    } else {  // If searchParam is a username
                        // Fetch customer_id based on the entered username
                        String customerSQL = "SELECT customer_id FROM customer WHERE username = ?";
                        pst = con.prepareStatement(customerSQL);
                        pst.setString(1, searchParam);
                        rs = pst.executeQuery();
                        
                        int customerId = -1;
                        if (rs.next()) {
                            customerId = rs.getInt("customer_id");
                        }
                        rs.close();
                        pst.close();

                        if (customerId != -1) {
                            combinedSQL = "SELECT c.username, 'Personal Loan' AS loanType, a.customer_id, a.loanAmount, a.loanTenure, a.status FROM personal_loan_applications a "
                                        + "JOIN customer c ON a.customer_id = c.customer_id WHERE a.customer_id = ? AND a.status = 'Approved' "
                                        + "UNION ALL "
                                        + "SELECT c.username, 'Vehicle Loan' AS loanType, a.customer_id, a.loanAmount, a.loanTenure, a.status FROM vehicle_loan_applications a "
                                        + "JOIN customer c ON a.customer_id = c.customer_id WHERE a.customer_id = ? AND a.status = 'Approved' "
                                        + "UNION ALL "
                                        + "SELECT c.username, 'Home Loan' AS loanType, a.customer_id, a.loanAmount, a.loanTenure, a.status FROM home_loan_applications a "
                                        + "JOIN customer c ON a.customer_id = c.customer_id WHERE a.customer_id = ? AND a.status = 'Approved' "
                                        + "UNION ALL "
                                        + "SELECT c.username, 'Education Loan' AS loanType, a.customer_id, a.loanAmount, a.loanTenure, a.status FROM education_loan_applications a "
                                        + "JOIN customer c ON a.customer_id = c.customer_id WHERE a.customer_id = ? AND a.status = 'Approved'";
                            pst = con.prepareStatement(combinedSQL);
                            pst.setInt(1, customerId);
                            pst.setInt(2, customerId);
                            pst.setInt(3, customerId);
                            pst.setInt(4, customerId);
                        }
                    }
                } else {
                    combinedSQL = "SELECT c.username, 'Personal Loan' AS loanType, a.customer_id, a.loanAmount, a.loanTenure, a.status FROM personal_loan_applications a "
                                + "JOIN customer c ON a.customer_id = c.customer_id WHERE a.status = 'Approved' "
                                + "UNION ALL "
                                + "SELECT c.username, 'Vehicle Loan' AS loanType, a.customer_id, a.loanAmount, a.loanTenure, a.status FROM vehicle_loan_applications a "
                                + "JOIN customer c ON a.customer_id = c.customer_id WHERE a.status = 'Approved' "
                                + "UNION ALL "
                                + "SELECT c.username, 'Home Loan' AS loanType, a.customer_id, a.loanAmount, a.loanTenure, a.status FROM home_loan_applications a "
                                + "JOIN customer c ON a.customer_id = c.customer_id WHERE a.status = 'Approved' "
                                + "UNION ALL "
                                + "SELECT c.username, 'Education Loan' AS loanType, a.customer_id, a.loanAmount, a.loanTenure, a.status FROM education_loan_applications a "
                                + "JOIN customer c ON a.customer_id = c.customer_id WHERE a.status = 'Approved'";
                    pst = con.prepareStatement(combinedSQL);
                }

                if (!combinedSQL.isEmpty()) {
                    rs = pst.executeQuery();
                    if (rs.isBeforeFirst()) { // Check if the ResultSet is not empty
                        hasLoans = true;
                        %>
                        <table>
                            <tr>
                                <th>Username</th>
                                <th>Loan Type</th>
                                <th>Customer ID</th>
                                <th>Loan Amount</th>
                                <th>Loan Tenure</th>
                                <th>Status</th>
                            </tr>
                        <%
                        while (rs.next()) {
                            %>
                            <tr>
                                <td><%= rs.getString("username") %></td>
                                <td><%= rs.getString("loanType") %></td>
                                <td><%= rs.getString("customer_id") %></td>
                                <td><%= rs.getString("loanAmount") %></td>
                                <td><%= rs.getString("loanTenure") %></td>
                                <td><%= rs.getString("status") %></td>
                            </tr>
                            <%
                        }
                        %>
                        </table>
                        <%
                    }
                }

                if (!hasLoans) {
                    %>
                    <div class="no-loans-message">
                        No approved loans found for the given username or customer ID.
                    </div>
                    <%
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
         <a href="admin-customer-loans.jsp" class="button">back</a>
    </div>
</body>
</html>
