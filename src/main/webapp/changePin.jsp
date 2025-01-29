<%@ page import="java.sql.*" %>
<%
    // Database connection setup
    String url = "jdbc:mysql://localhost:3306/bankdb";
    String user = "root";
    String password0 = "Layavardhan@2003";
    Connection con = DriverManager.getConnection(url, user, password0);

    String message = "";
    int customerId = 0;

    // Retrieve the username from the session
    String username = (String) session.getAttribute("username");

    // Fetch the customer_id based on the username
    try {
        PreparedStatement ps = con.prepareStatement("SELECT customer_id FROM customer WHERE username = ?");
        ps.setString(1, username);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            customerId = rs.getInt("customer_id");
        }
    } catch (SQLException e) {
        e.printStackTrace();
        message = "An error occurred while fetching customer ID.";
    }

    if (request.getMethod().equalsIgnoreCase("POST")) {
        String currentPin = request.getParameter("currentPin");
        String newPin = request.getParameter("newPin");

        try {
            // Check if the current PIN is correct
            PreparedStatement ps = con.prepareStatement("SELECT pin FROM customer WHERE customer_id = ?");
            ps.setInt(1, customerId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                String existingPin = rs.getString("pin");
                if (existingPin.equals(currentPin)) {
                    // Update the PIN with the new one
                    ps = con.prepareStatement("UPDATE customer SET pin = ? WHERE customer_id = ?");
                    ps.setString(1, newPin);
                    ps.setInt(2, customerId);
                    int result = ps.executeUpdate();

                    if (result > 0) {
                        message = "PIN updated successfully!";
                    } else {
                        message = "Failed to update PIN. Please try again.";
                    }
                } else {
                    message = "Current PIN is incorrect.";
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            message = "An error occurred. Please try again.";
        }
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Change PIN</title>
    <style>
       body {
    font-family: Arial, sans-serif;
    background-color: #1a1a1a;
    color: #fff;
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100vh;
    margin: 0;
    overflow: hidden;
}

h2 {
    text-align: center;
    margin-bottom: 20px;
}

form {
    background-color: #333;
    padding: 40px;
    border-radius: 10px;
    box-shadow: 0 0 20px rgba(255, 255, 255, 0.1);
    position: relative;
    overflow: hidden;
    z-index: 1; /* Ensure form is above pseudo-elements */
}

form::before {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    border-radius: 10px;
    box-shadow: 0 0 15px rgba(255, 255, 255, 0.5), 0 0 25px rgba(255, 255, 255, 0.3), 0 0 35px rgba(255, 255, 255, 0.2);
    animation: sparkling 1.5s infinite;
    pointer-events: none; /* Ensure it doesn't block interactions */
    z-index: -1; /* Ensure it's below the form content */
}

@keyframes sparkling {
    0% {
        box-shadow: 0 0 15px rgba(255, 255, 255, 0.5), 0 0 25px rgba(255, 255, 255, 0.3), 0 0 35px rgba(255, 255, 255, 0.2);
    }
    50% {
        box-shadow: 0 0 20px rgba(255, 255, 255, 0.7), 0 0 30px rgba(255, 255, 255, 0.4), 0 0 40px rgba(255, 255, 255, 0.3);
    }
    100% {
        box-shadow: 0 0 15px rgba(255, 255, 255, 0.5), 0 0 25px rgba(255, 255, 255, 0.3), 0 0 35px rgba(255, 255, 255, 0.2);
    }
}

form label {
    display: block;
    margin-bottom: 10px;
}

form input[type="password"] {
    width: calc(100% - 20px); /* Adjust width for padding */
    padding: 10px;
    margin-bottom: 20px;
    border: none;
    border-radius: 5px;
    background-color: #444;
    color: #fff;
}

.button-container {
    display: flex;
    gap: 10px;
    justify-content: center;
    margin-top: 20px;
}

button {
    background-color: #008080; /* Teal color */
    border: none;
    padding: 10px 20px;
    color: white;
    cursor: pointer;
    border-radius: 5px;
    font-size: 16px;
    transition: background-color 0.3s ease;
}

button:hover {
    background-color: #66c2c2; /* Lighter teal color */
}

.back-button {
    display: inline-block;
    padding: 10px 20px;
    background-color: #666;
    color: white;
    border-radius: 5px;
    text-align: center;
    text-decoration: none;
    font-size: 16px;
    transition: background-color 0.3s ease;
}

.back-button:hover {
    background-color: #888;
}

p {
    text-align: center;
    margin-top: 20px;
}


    </style>
</head>
<body>
    <div>
        <h2>Change Your PIN</h2>
        <form method="post" action="changePin.jsp">
            <label for="currentPin">Current PIN:</label>
            <input type="password" id="currentPin" name="currentPin" required>

            <label for="newPin">New PIN:</label>
            <input type="password" id="newPin" name="newPin" pattern="\d{4}" required>

            <div class="button-container">
        <button type="submit">Change PIN</button>
        <a href="customer-dashboard.jsp" class="back-button">Back</a>
    </div>
        </form>

        <% if (!message.isEmpty()) { %>
            <p><%= message %></p>
        <% } %>
    </div>
</body>
</html>
