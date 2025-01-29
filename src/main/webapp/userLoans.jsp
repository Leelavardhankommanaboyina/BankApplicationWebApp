<%@ page import="java.sql.*, javax.servlet.http.*, javax.servlet.*" %>
<%@ page import="java.util.*" %>
<%
    // Fetch username from session
    String username = (String) session.getAttribute("username");

    if (username == null) {
        response.sendRedirect("customer-login.jsp");
        return;
    }

    // Database connection
    Connection con = null;
    PreparedStatement pst = null;
    ResultSet rs = null;
    List<Map<String, String>> loanDetails = new ArrayList<>();

    try {
        Class.forName("com.mysql.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/bankdb", "root", "Layavardhan@2003");

        // Fetch customer_id using username
        String selectCustomerSQL = "SELECT customer_id FROM customer WHERE username = ?";
        pst = con.prepareStatement(selectCustomerSQL);
        pst.setString(1, username);
        rs = pst.executeQuery();

        int customerId = -1; // Initialize with an invalid value
        if (rs.next()) {
            customerId = rs.getInt("customer_id");
        }

        if (customerId != -1) {
            // Combined query to fetch loans from all tables
            String combinedSQL = "SELECT loanType, loanAmount, loanTenure, status, application_date FROM personal_loan_applications WHERE customer_id = ? "
                                + "UNION ALL "
                                + "SELECT loanType, loanAmount, loanTenure, status, application_date FROM vehicle_loan_applications WHERE customer_id = ? "
                                + "UNION ALL "
                                + "SELECT loanType, loanAmount, loanTenure, status, application_date FROM home_loan_applications WHERE customer_id = ? "
                                + "UNION ALL "
                                + "SELECT loanType, loanAmount, loanTenure, status, application_date FROM education_loan_applications WHERE customer_id = ?";

            pst = con.prepareStatement(combinedSQL);
            pst.setInt(1, customerId);
            pst.setInt(2, customerId);
            pst.setInt(3, customerId);
            pst.setInt(4, customerId);
            rs = pst.executeQuery();

            while (rs.next()) {
                Map<String, String> loanDetail = new HashMap<>();
                loanDetail.put("loanType", rs.getString("loanType"));
                loanDetail.put("loanAmount", rs.getString("loanAmount"));
                loanDetail.put("loanTenure", rs.getString("loanTenure"));
                loanDetail.put("application_date", rs.getString("application_date"));
                loanDetail.put("status", rs.getString("status"));
               
                loanDetails.add(loanDetail);
            }
        } else {
            out.println("No customer found with the given username.");
        }
    } catch (ClassNotFoundException e) {
        e.printStackTrace();
        out.println("Database driver not found.");
    } catch (SQLException e) {
        e.printStackTrace();
        out.println("Database error: " + e.getMessage());
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
    <title>Your Loan Applications</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #87CEEB; /* Light blue background */
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .table-container {
            width: 80%;
            max-width: 800px;
            margin: 0 auto;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            background: rgba(255, 255, 255, 0.8); /* Transparent background */
            padding: 20px;
            border-radius: 8px;
            text-align: center;
            animation: fadeIn 1.5s ease-in-out, slideUp 1s ease-in-out;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin: 20px 0;
            animation: tableFadeIn 2s ease-in-out;
        }
        th, td {
            padding: 12px;
            border: none; /* Remove border lines */
            text-align: left;
            transition: background-color 0.3s ease, color 0.3s ease;
        }
        th {
            background-color: #ADD8E6; /* Light blue color for table headers */
            animation: thFadeIn 1s ease-in-out;
        }
        tr:nth-child(even) {
            background-color: #f9f9f9;
        }
        tr:hover td {
            background-color: #1E90FF; /* Blue color on hover */
            color: #fff;
            animation: pulse 0.5s ease-in-out infinite alternate;
            transform: scale(1.05);
            transition: transform 0.2s ease-out, background-color 0.2s ease-out, box-shadow 0.2s ease-out;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.2);
            z-index: 1;
        }
        h2 {
            text-align: center;
            margin-top: 20px;
            color: #333;
            animation: slideDown 1s ease-in-out;
        }
        /* CSS animations */
        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }
        @keyframes slideUp {
            from { transform: translateY(20px); }
            to { transform: translateY(0); }
        }
        @keyframes tableFadeIn {
            from { opacity: 0; transform: scale(0.95); }
            to { opacity: 1; transform: scale(1); }
        }
        @keyframes thFadeIn {
            from { opacity: 0; transform: translateY(-10px); }
            to { opacity: 1; transform: translateY(0); }
        }
        @keyframes slideDown {
            from { transform: translateY(-20px); opacity: 0; }
            to { transform: translateY(0); opacity: 1; }
        }
        @keyframes pulse {
            from {
                transform: scale(1);
                background-color: #1E90FF;
            }
            to {
                transform: scale(1.02);
                background-color: #ADD8E6;
            }
        }
    </style>
</head>
<body>
    <div class="table-container">
        <h2>Your Loan Applications</h2>
        <table>
            <thead>
                <tr>
                    <th>Loan Type</th>
                    <th>Loan Amount</th>
                    <th>Loan Tenure</th>
                    <th>Application Date</th>
                    <th>Status</th>
                </tr>
            </thead>
            <tbody>
                <% for (Map<String, String> loan : loanDetails) { %>
                <tr>
                    <td><%= loan.get("loanType") %></td>
                    <td><%= loan.get("loanAmount") %></td>
                    <td><%= loan.get("loanTenure") %></td>
                    <td><%= loan.get("application_date") %></td>
                    <td><%= loan.get("status") %></td>
                </tr>
                <% } %>
            </tbody>
        </table>
        <a href="customer-dashboard.jsp" class="button">back</a>
    </div>
     
</body>
</html>
