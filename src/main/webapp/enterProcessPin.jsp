<%@ page import="java.sql.*, java.util.*, java.text.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Enter PIN</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }

        .pin-container {
            background-color: white;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
            text-align: center;
            width: 300px; /* Adjusted width for a better size */
        }

        .pin-container h2 {
            margin-bottom: 20px;
            font-size: 24px; /* Adjusted font size */
        }

        .pin-container input[type="password"] {
            padding: 5px;
            font-size: 16px;
            border: 2px solid #ccc;
            border-radius: 4px;
            width: 100%;
            margin-bottom: 20px;
            text-align: center;
        }

        .pin-container input[type="submit"] {
            padding: 10px;
            font-size: 18px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            width: 90%;
            transition: background-color 0.3s ease;
        }

        .pin-container input[type="submit"]:hover {
            background-color: #0056b3;
        }

        .error-message {
            color: red;
            margin-top: 10px;
            font-size: 14px;
        }
    </style>
</head>
<body>
    <div class="pin-container">
        <h2>Enter Your PIN</h2>
        <%
            String enteredPin = request.getParameter("pin");
            String username = (String) session.getAttribute("username");
            String action = request.getParameter("action");
            String errorMessage = null;

            if (enteredPin != null && action != null && action.equals("verifyPin")) {
                Connection con = null;
                PreparedStatement pst = null;
                ResultSet rs = null;

                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    con = DriverManager.getConnection("jdbc:mysql://localhost:3306/bankdb", "root", "Layavardhan@2003");

                    // Fetch stored PIN using username
                    String query = "SELECT pin FROM customer WHERE username = ?";
                    pst = con.prepareStatement(query);
                    pst.setString(1, username);
                    rs = pst.executeQuery();

                    if (rs.next()) {
                        String storedPin = rs.getString("pin");
                        if (enteredPin.equals(storedPin)) {
                            // Redirect to processPayment.jsp if PIN is correct
                            response.sendRedirect("processPayment.jsp?loanType=" + request.getParameter("loanType") + "&applicationDate=" + request.getParameter("applicationDate"));
                        } else {
                            errorMessage = "Incorrect PIN. Please enter the correct PIN.";
                        }
                    } else {
                        errorMessage = "User not found.";
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                    errorMessage = "Error: " + e.getMessage();
                } finally {
                    try { if (rs != null) rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                    try { if (pst != null) pst.close(); } catch (SQLException e) { e.printStackTrace(); }
                    try { if (con != null) con.close(); } catch (SQLException e) { e.printStackTrace(); }
                }
            }
        %>

        <form action="enterProcessPin.jsp" method="post">
            <input type="password" name="pin" placeholder="Enter your PIN" required>
            <input type="hidden" name="loanType" value="<%= request.getParameter("loanType") %>">
            <input type="hidden" name="applicationDate" value="<%= request.getParameter("applicationDate") %>">
            <input type="hidden" name="action" value="verifyPin">
            <input type="submit" value="Confirm">
        </form>

        <% if (errorMessage != null) { %>
            <p class="error-message"><%= errorMessage %></p>
        <% } %>
    </div>
</body>
</html>
