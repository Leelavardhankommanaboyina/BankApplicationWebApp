<%@ page import="java.sql.*" %>
<%
    String username = (String) session.getAttribute("username");
String url = "jdbc:mysql://localhost:3306/bankdb";
String user = "root";
String password0 = "Layavardhan@2003";
Connection con = DriverManager.getConnection(url, user, password0);
    int customerId = 0;
    String pin = null;

    if (username != null) {
        try {
            // Assuming you have a database connection setup as 'con'
            if (con != null) {
                PreparedStatement ps = con.prepareStatement("SELECT customer_id, pin FROM customer WHERE username = ?");
                ps.setString(1, username);
                ResultSet rs = ps.executeQuery();
                if (rs.next()) {
                    customerId = rs.getInt("customer_id");
                    pin = rs.getString("pin");
                }
            } else {
                System.out.println("Database connection is not initialized.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    } else {
        System.out.println("Username is not set in session.");
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Customer Dashboard</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #1c1c1c;
            color: #fff;
            text-align: center;
            margin-top: 50px;
        }
        .navbar {
            display: flex;
            align-items: center;
            background-color: #000000; /* Set navbar to black */
            padding: 6px 24px;
            width: 95%;
            position: fixed;
            top: 0;
            z-index: 1000;
            justify-content: space-between;
            height: 50px; /* Reduced height */
        }
        .navbar img.home-icon {
            height: 35px;
            width: 35px;
            border-radius: 50%;
            margin-right: 10px;
        }
        .navbar a {
            color: white;
            text-decoration: none;
            padding: 10px 15px;
            font-size: 16px;
            transition: background-color 0.3s;
        }
        .navbar a:hover,
        .navbar a.active {
            background-color: #0056b3;
        }
        .profile-container {
            margin-left: auto;
            margin-right: 1cm;
            display: flex;
            align-items: center;
        }
        .profile-dropdown {
            position: relative;
            display: inline-block;
        }
        .profile-dropdown button {
            background-color: black;
            color: white;
            border: none;
            padding: 10px 15px;
            font-size: 16px;
            cursor: pointer;
            display: flex;
            align-items: center;
        }
        
        .profile-dropdown-content {
            display: none;
            position: absolute;
            background-color: #f9f9f9;
            min-width: 160px;
            box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
            z-index: 1;
        }
        .profile-dropdown-content a,
        .profile-dropdown-content form {
            color: black;
            padding: 12px 16px;
            text-decoration: none;
            display: block;
            font-size: 14px;
        }
        .profile-dropdown-content a:hover {
            background-color: #f1f1f1;
        }
        .profile-dropdown:hover .profile-dropdown-content {
            display: block;
        }
        .profile-dropdown:hover button.logout-btn {
            background-color: #ff0000; /* Ensure logout button stays red on hover */
        }
        .logout-btn {
            display: inline-block;
            padding: 10px 20px;
            font-size: 14px;
            text-decoration: none;
            background-color: #ff0000; /* Red color */
            color: #fff;
            border-radius: 5px;
            transition: background-color 0.3s;
            border: none;
        }
        .logout-btn:hover {
            background-color: #cc0000; /* Darker red on hover */
        }
        .container {
            width: 80%;
            margin: auto;
            padding: 20px;
            margin-top: 80px;
        }
        .card-container {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            gap: 20px;
        }
        .card {
            background-color: #6c757d;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            padding: 20px;
            width: calc(20% - 20px);
            box-sizing: border-box;
            color: #fff;
            text-align: center;
            transition: transform 0.5s, box-shadow 0.5s;
            cursor: pointer;
        }
        .card:hover {
            transform: scale(1.05);
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.2);
        }
        .card h3 {
            margin-top: 20px;
            font-size: 22px;
        }
        .card p {
            font-size: 16px;
            margin-top: 10px;
        }
        @keyframes blink {
            0% { box-shadow: 0 0 15px rgba(255, 255, 255, 0.5); }
            50% { box-shadow: 0 0 15px rgba(255, 255, 255, 1); }
            100% { box-shadow: 0 0 15px rgba(255, 255, 255, 0.5); }
        }
        .card {
            animation: blink 2s infinite;
        }
    </style>
    <!-- Font Awesome CDN -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>
<body>
    <div class="navbar">
        <a href="index.jsp">
            <img src="bankLogo.jpeg" alt="Home" class="home-icon">
        </a>
        <div class="profile-container">
            <div class="profile-dropdown">
                <button class="dropbtn">
                    <i class="fas fa-user-circle"></i> <!-- User profile icon -->
                    <%= session.getAttribute("username") %>
                </button>
               <div class="profile-dropdown-content">
               <a href="changePin.jsp">Change PIN</a> <!-- New link for changing PIN -->
    <a href="changePassword.jsp">Change Password</a>
     <form action="index.jsp" method="post" style="margin: 0;">
        <button type="submit" class="logout-btn">Logout</button>
    </form>
</div>

            </div>
        </div>
    </div>

    <div class="container">
        <h2>Welcome to Your Dashboard</h2>
        
       <% if (pin == null) { %>
    <form action="setPin.jsp" method="post">
        <button type="submit" class="set-pin">CLICK HERE TO SET YOUR PIN FOR TRANSACTIONS</button>
    </form>
<% } %>

        
        
        <div class="card-container">
        <div class="card" onclick="window.location.href='depositToFriend.jsp'">
               <h3>Send Money</h3>
         </div>
            <div class="card" onclick="window.location.href='enterPin.jsp?action=checkBalance'">
         <h3>Check Balance</h3>
         </div>
          <div class="card" onclick="window.location.href='loansDashBoard.jsp'">
                <h3>Loans</h3>
            </div>
            <div class="card" onclick="window.location.href='TransactionHistoryServlet'">
                <h3>Transaction History</h3>
            </div>
            
        </div>
    </div>
</body>
</html>
