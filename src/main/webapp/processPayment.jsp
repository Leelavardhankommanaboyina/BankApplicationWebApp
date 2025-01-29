<%@ page import="java.sql.*, java.util.*, java.text.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Payment Process</title>
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
            text-align: center;
            display: none; /* Initially hidden */
        }
        #timer {
            font-size: 24px;
            margin-bottom: 20px;
        }
        .qr-code {
            margin-top: 20px;
        }
        .qr-code img {
            width: 150px;
            height: 150px;
        }
        .button {
            display: inline-block;
            padding: 10px 20px;
            margin-top: 20px;
            font-size: 16px;
            color: white;
            background-color: #007bff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            text-decoration: none;
        }
        .button:hover {
            background-color: #0056b3;
        }
        .spinner {
            border: 16px solid #f3f3f3; /* Light grey */
            border-top: 16px solid #3498db; /* Blue */
            border-radius: 50%;
            width: 120px;
            height: 120px;
            animation: spin 2s linear infinite;
            margin-bottom: 20px;
        }
        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }
    </style>
    <script>
        function startTimer(duration, redirectUrl) {
            var timer = duration, minutes, seconds;
            var display = document.querySelector('#timer');
            var interval = setInterval(function () {
                minutes = parseInt(timer / 60, 10);
                seconds = parseInt(timer % 60, 10);
                minutes = minutes < 10 ? "0" + minutes : minutes;
                seconds = seconds < 10 ? "0" + seconds : seconds;
                display.textContent = minutes + ":" + seconds;
                if (--timer < 0) {
                    clearInterval(interval);
                    // Hide the spinner and show the container
                    document.querySelector('.spinner').style.display = 'none';
                    document.querySelector('.container').style.display = 'block';
                    // Redirect after displaying the container
                    setTimeout(function() {
                        window.location.href = redirectUrl;
                    }, 500); // Slight delay to allow container to be visible
                }
            }, 1000);
        }

        window.onload = function () {
            var tenSeconds = 10,
                redirectUrl = 'paymentSuccessfully.jsp';
            startTimer(tenSeconds, redirectUrl);
        };
    </script>
</head>
<body>
    <div class="spinner"></div>
    <div class="container">
        <h1>Payment Process</h1>
        <div id="timer"></div>

        <%
            String loanType = request.getParameter("loanType");
            String applicationDate = request.getParameter("applicationDate");
            String username = (String) session.getAttribute("username");

            Connection con = null;
            PreparedStatement pst = null;
            ResultSet rs = null;
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                con = DriverManager.getConnection("jdbc:mysql://localhost:3306/bankdb", "root", "Layavardhan@2003");

                // Fetch customer_id using username
                String customerIdSQL = "SELECT customer_id FROM customer WHERE username = ?";
                pst = con.prepareStatement(customerIdSQL);
                pst.setString(1, username);
                rs = pst.executeQuery();
                int customerId = 0;
                if (rs.next()) {
                    customerId = rs.getInt("customer_id");
                }
                rs.close();

                // Debug: Print customer_id
                out.println("Customer ID: " + customerId);
                out.println("Loan Type: " + loanType);

                if (loanType != null && !loanType.isEmpty()) {
                    // Fetch loanAmount using customer_id and application_date
                    String fetchLoanAmountSQL = "SELECT loanAmount FROM " + loanType + " WHERE customer_id = ? AND application_date = ?";
                    pst = con.prepareStatement(fetchLoanAmountSQL);
                    pst.setInt(1, customerId);
                    pst.setTimestamp(2, Timestamp.valueOf(applicationDate));
                    rs = pst.executeQuery();
                    double loanAmount = 0;
                    if (rs.next()) {
                        loanAmount = rs.getDouble("loanAmount");
                    }
                    rs.close();

                    // Update loan status to 'cleared'
                    String updateLoanStatusSQL = "UPDATE " + loanType + " SET status = 'cleared' WHERE customer_id = ? AND application_date = ?";
                    pst = con.prepareStatement(updateLoanStatusSQL);
                    pst.setInt(1, customerId);
                    pst.setTimestamp(2, Timestamp.valueOf(applicationDate));
                    int rowsAffected = pst.executeUpdate();
                    
                    // Update customer's balance
                    if (rowsAffected > 0) {
                        String updateCustomerBalanceSQL = "UPDATE customer SET balance = balance - ? WHERE customer_id = ?";
                        pst = con.prepareStatement(updateCustomerBalanceSQL);
                        pst.setDouble(1, loanAmount);
                        pst.setInt(2, customerId);
                        int balanceUpdateRows = pst.executeUpdate();
                        
                        if (balanceUpdateRows > 0) {
                            // No need to redirect here as JavaScript will handle it
                        } else {
                            out.println("Failed to update the customer's balance.");
                        }
                    } else {
                        out.println("Failed to update the loan status.");
                    }
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
        
    </div>
</body>
</html>
