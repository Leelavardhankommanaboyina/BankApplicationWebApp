<%@ page import="java.sql.*, java.util.*, java.text.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Loan Payment</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: linear-gradient(45deg, #f3f4f6, #e2e2e2);
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            flex-direction: column;
            min-height: 100vh;
            position: relative;
            overflow: hidden;
        }
        .container {
            width: 40%;
            background: white;
            padding: 20px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
            border-radius: 10px;
            animation: slideUp 1s ease-out;
            display: flex;
            flex-direction: column;
            align-items: center;
        }
        h1 {
            text-align: center;
            color: #333;
        }
        select {
            padding: 10px;
            border-radius: 5px;
            border: 1px solid #ccc;
            margin-bottom: 20px;
            transition: transform 0.3s;
        }
        select:focus {
            outline: none;
            border-color: #0056b3;
            transform: scale(1.05);
        }
        .loan-details {
            margin-top: 20px;
            width: 100%;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            animation: fadeIn 1s ease-out;
        }
        table, th, td {
            border: 1px solid #ccc;
        }
        th, td {
            padding: 5px; /* Reduced padding for smaller rows */
            text-align: center;
        }
        th {
            background-color: #f2f2f2;
        }
        input[type="submit"] {
            padding: 10px;
            border-radius: 5px;
            border: none;
            background-color: #007bff;
            color: white;
            cursor: pointer;
            transition: background-color 0.3s, box-shadow 0.3s;
            margin-bottom: 20px;
        }
        input[type="submit"]:hover {
            background-color: #0056b3;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }
        @keyframes slideUp {
            from {
                transform: translateY(20px);
                opacity: 0;
            }
            to {
                transform: translateY(0);
                opacity: 1;
            }
        }
        @keyframes fadeIn {
            from {
                opacity: 0;
            }
            to {
                opacity: 1;
            }
        }
        .background-animation {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: radial-gradient(circle, rgba(255,255,255,0.1) 10%, transparent 30%);
            opacity: 0.5;
            pointer-events: none;
            animation: moveBackground 15s linear infinite;
        }
        @keyframes moveBackground {
            0% {
                background-position: 0 0;
            }
            100% {
                background-position: 100% 100%;
            }
        }
    </style>
</head>
<body>
    <div class="background-animation"></div>
    <div class="container">
        <h1>Loan Payment</h1>

        <form method="get" action="loanPayment.jsp" style="display: flex; justify-content: center; width: 100%;">
            <label for="loanType" style="margin-right: 10px;">Select Loan Type:</label>
            <select id="loanType" name="loanType" onchange="this.form.submit()">
                <option value="">--Select--</option>
                <option value="personal_loan_applications" <%= request.getParameter("loanType") != null && request.getParameter("loanType").equals("personal_loan_applications") ? "selected" : "" %>>Personal Loan</option>
                <option value="vehicle_loan_applications" <%= request.getParameter("loanType") != null && request.getParameter("loanType").equals("vehicle_loan_applications") ? "selected" : "" %>>Vehicle Loan</option>
                <option value="home_loan_applications" <%= request.getParameter("loanType") != null && request.getParameter("loanType").equals("home_loan_applications") ? "selected" : "" %>>Home Loan</option>
                <option value="education_loan_applications" <%= request.getParameter("loanType") != null && request.getParameter("loanType").equals("education_loan_applications") ? "selected" : "" %>>Education Loan</option>
            </select>
        </form>

        <%
            String loanType = request.getParameter("loanType");
            String username = (String) session.getAttribute("username"); // Replace with actual username logic
            
            if (loanType != null && !loanType.isEmpty()) {
                Connection con = null;
                PreparedStatement pst = null;
                ResultSet rs = null;
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    con = DriverManager.getConnection("jdbc:mysql://localhost:3306/bankdb", "root", "Layavardhan@2003");

                    String sql = "SELECT * FROM " + loanType + " WHERE customer_id = (SELECT customer_id FROM customer WHERE username = ?) AND status = 'approved'";
                    pst = con.prepareStatement(sql);
                    pst.setString(1, username);
                    rs = pst.executeQuery();

                    if (rs.isBeforeFirst()) {
                        %>
                        <div class="loan-details">
                            <form method="post" action="displayLoanAmount.jsp">
                                <table>
                                    <tr>
                                        <th>Application Date</th>
                                        <th>Loan Amount</th>
                                        <th>Loan Tenure</th>
                                        <th>Select</th>
                                    </tr>
                                    <%
                                    while (rs.next()) {
                                        Timestamp applicationDate = rs.getTimestamp("application_date");
                                        double loanAmount = rs.getDouble("loanAmount");
                                        int loanTenure = rs.getInt("loanTenure"); // Assuming loanTenure is an integer
                                        %>
                                        <tr>
                                            <td><%= applicationDate %></td>
                                            <td><%= loanAmount %></td>
                                            <td><%= loanTenure %></td>
                                            <td>
                                               <input type="hidden" name="loanType" value="<%= loanType %>">
                                               <input type="hidden" name="loanAmount" value="<%= loanAmount %>">
                                                <input type="hidden" name="applicationDate" value="<%= applicationDate %>">
                                                <input type="submit" value="Pay">
                                            </td>
                                        </tr>
                                        <%
                                    }
                                    %>
                                </table>
                            </form>
                        </div>
                        <%
                    } else {
                        %>
                        <p>No loans available for payment.</p>
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
            }
        %>
    </div>
</body>
</html>
