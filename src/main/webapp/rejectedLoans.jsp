<%@ page import="java.sql.*, java.util.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Rejected Loan Applications</title>
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
        }
        .container {
            width: 80%;
            background: white;
            padding: 20px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
            border-radius: 10px;
            animation: fadeIn 1s ease-in-out;
        }
        h1 {
            text-align: center;
            color: #333;
            animation: slideIn 1s ease-in-out;
        }
        .search-bar {
            margin-bottom: 20px;
            text-align: center;
        }
        .search-bar input[type="text"] {
            width: 23%;
            padding: 10px;
            border-radius: 5px;
            border: 1px solid #ccc;
            transition: border-color 0.3s ease;
        }
        .search-bar input[type="text"]:focus {
            border-color: #dc3545;
            outline: none;
        }
        .search-bar input[type="submit"] {
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            background-color: #dc3545;
            color: white;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }
        .search-bar input[type="submit"]:hover {
            background-color: #c82333;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            animation: fadeIn 1s ease-in-out;
        }
        table, th, td {
            border: 1px solid #ccc;
        }
        th, td {
            padding: 10px;
            text-align: center;
            transition: background-color 0.3s ease;
        }
        th {
            background-color: #f2f2f2;
        }
        tr:hover {
            background-color: #f1f1f1;
        }
        .no-loans-message {
            text-align: center;
            color: red;
            margin-top: 20px;
            animation: fadeIn 1s ease-in-out;
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
        <h1>Rejected Loan Applications</h1>

        <div class="search-bar">
            <form method="get" action="rejectedLoans.jsp">
                <input type="text" name="search" placeholder="Enter username or customer ID to search...">
                <input type="submit" value="Search">
            </form>
        </div>

        <%
            // Database connection
            Connection con = null;
            PreparedStatement pst = null;
            ResultSet rs = null;
            String searchInput = request.getParameter("search");
            boolean hasLoans = false;

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                con = DriverManager.getConnection("jdbc:mysql://localhost:3306/bankdb", "root", "Layavardhan@2003");

                String combinedSQL = "";
                if (searchInput != null && !searchInput.isEmpty()) {
                    // Check if searchInput is a numeric value (customer_id)
                    boolean isCustomerId = searchInput.matches("\\d+");
                    int customerId = -1;
                    String username = null;

                    if (isCustomerId) {
                        customerId = Integer.parseInt(searchInput);
                    } else {
                        // Fetch customer_id based on the entered username
                        String customerSQL = "SELECT customer_id, username FROM customer WHERE username = ?";
                        pst = con.prepareStatement(customerSQL);
                        pst.setString(1, searchInput);
                        rs = pst.executeQuery();
                        
                        if (rs.next()) {
                            customerId = rs.getInt("customer_id");
                            username = rs.getString("username");
                        }
                        rs.close();
                        pst.close();
                    }

                    if (customerId != -1) {
                    	 combinedSQL = "SELECT c.username, 'Personal Loan' AS loanType, a.customer_id, a.loanAmount, a.loanTenure, a.status FROM personal_loan_applications a "
                                 + "JOIN customer c ON a.customer_id = c.customer_id WHERE a.customer_id = ? AND a.status = 'rejected' "
                                 + "UNION ALL "
                                 + "SELECT c.username, 'Vehicle Loan' AS loanType, a.customer_id, a.loanAmount, a.loanTenure, a.status FROM vehicle_loan_applications a "
                                 + "JOIN customer c ON a.customer_id = c.customer_id WHERE a.customer_id = ? AND a.status = 'rejected' "
                                 + "UNION ALL "
                                 + "SELECT c.username, 'Home Loan' AS loanType, a.customer_id, a.loanAmount, a.loanTenure, a.status FROM home_loan_applications a "
                                 + "JOIN customer c ON a.customer_id = c.customer_id WHERE a.customer_id = ? AND a.status = 'rejected' "
                                 + "UNION ALL "
                                 + "SELECT c.username, 'Education Loan' AS loanType, a.customer_id, a.loanAmount, a.loanTenure, a.status FROM education_loan_applications a "
                                 + "JOIN customer c ON a.customer_id = c.customer_id WHERE a.customer_id = ? AND a.status = 'rejected'";
                     pst = con.prepareStatement(combinedSQL);
                     pst.setInt(1, customerId);
                     pst.setInt(2, customerId);
                     pst.setInt(3, customerId);
                     pst.setInt(4, customerId);
                    }
                } else {
                	combinedSQL = "SELECT c.username, 'Personal Loan' AS loanType, a.customer_id, a.loanAmount, a.loanTenure, a.status FROM personal_loan_applications a "
                            + "JOIN customer c ON a.customer_id = c.customer_id WHERE a.status = 'rejected' "
                            + "UNION ALL "
                            + "SELECT c.username, 'Vehicle Loan' AS loanType, a.customer_id, a.loanAmount, a.loanTenure, a.status FROM vehicle_loan_applications a "
                            + "JOIN customer c ON a.customer_id = c.customer_id WHERE a.status = 'rejected' "
                            + "UNION ALL "
                            + "SELECT c.username, 'Home Loan' AS loanType, a.customer_id, a.loanAmount, a.loanTenure, a.status FROM home_loan_applications a "
                            + "JOIN customer c ON a.customer_id = c.customer_id WHERE a.status = 'rejected' "
                            + "UNION ALL "
                            + "SELECT c.username, 'Education Loan' AS loanType, a.customer_id, a.loanAmount, a.loanTenure, a.status FROM education_loan_applications a "
                            + "JOIN customer c ON a.customer_id = c.customer_id WHERE a.status = 'rejected'";
                pst = con.prepareStatement(combinedSQL);
                }

                if (!combinedSQL.isEmpty()) {
                    rs = pst.executeQuery();
                    if (rs.isBeforeFirst()) { // Check if the ResultSet is not empty
                        hasLoans = true;
                        %>
                        <table>
                            <tr>
                                <th>Loan Type</th>
                                <th>Username</th>
                                <th>Customer ID</th>
                                <th>Loan Amount</th>
                                <th>Loan Tenure</th>
                                <th>Status</th>
                            </tr>
                        <%
                        while (rs.next()) {
                            %>
                            <tr>
                                <td><%= rs.getString("loanType") %></td>
                                <td><%= rs.getString("username") %></td>
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
                        This user does not have any rejected loans.
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
