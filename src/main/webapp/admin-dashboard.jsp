<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #1c1c1c; /* Dark background */
            color: #fff; /* White text color */
            text-align: center;
            margin-top: 50px;
        }
        .navbar img.home-icon {
            height: 35px;
            width: 35px;
            border-radius: 50%;
            margin-right: 10px;
        }
        .navbar {
            display: flex;
            align-items: center;
            background-color: #343a40; /* Darker navbar color */
            padding: 4px 10px; /* Reduced padding */
            width: 100%;
            position: fixed;
            top: 0;
            z-index: 1000;
            justify-content: space-between; /* Space between home and profile */
        }
        .navbar img.profile-photo {
            height: 35px; /* Adjusted height */
            border-radius: 50%;
            margin-right: 10px;
        }
        .navbar a {
            color: white;
            text-decoration: none;
            padding: 10px 15px; /* Adjusted padding */
            font-size: 16px; /* Adjusted font size */
            transition: background-color 0.3s;
        }
        .navbar a:hover,
        .navbar a.active {
            background-color: #0056b3;
        }
        .profile-container {
            margin-left: auto; /* Push profile container to the right */
            margin-right: 1cm; /* Gap from the end */
            display: flex;
            align-items: center;
        }
        .profile-dropdown {
            position: relative;
            display: inline-block;
        }
        .profile-dropdown button {
            background-color: #343a40;
            color: white;
            border: none;
            padding: 10px 15px;
            font-size: 16px;
            cursor: pointer;
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
        .profile-dropdown:hover button {
            background-color: #3e8e41;
        }
        .logout-btn {
            display: inline-block;
            padding: 10px 20px; /* Adjusted padding */
            font-size: 14px;
            text-decoration: none;
            background-color: #dc3545;
            color: #fff;
            border-radius: 5px;
            transition: background-color 0.3s;
        }
        .logout-btn:hover {
            background-color: #c82333;
        }
        .container {
            width: 80%;
            margin: auto;
            padding: 20px;
            margin-top: 80px; /* Adjusted for smaller navbar */
        }
        .card-container {
            display: flex;
            flex-wrap: wrap;
            justify-content: center; /* Center the cards */
            gap: 20px; /* Gap between cards */
        }
        .card {
            background-color: #6c757d; /* Grey background color */
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            padding: 20px;
            width: calc(20% - 20px); /* Two cards per row */
            box-sizing: border-box;
            color: #fff;
            text-align: center;
            transition: transform 0.5s, box-shadow 0.5s; /* Smooth transition for transform and shadow */
        }
        .card:hover {
            transform: scale(1.05); /* Slightly increase size on hover */
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.2);
        }
        .card h3 {
            margin-top: 20px;
            font-size: 22px;
            text-decoration: none; /* Remove underline from h3 tags within card links */
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
            animation: blink 2s infinite; /* Blinking light effect */
        }
        .card a h3 {
            text-decoration: none; /* Remove underline from h3 tags within card links */
            color: inherit; /* Ensure the text color stays the same */
        }
    </style>
</head>
<body>
    <div class="navbar">
       <a href="index.jsp">
            <img src="bankLogo.jpeg" alt="Home" class="home-icon">
        </a>
        <div class="profile-container">
            <div class="profile-dropdown">
                <button class="dropbtn">Welcome, <%= session.getAttribute("adminUsername") %></button>
                <div class="profile-dropdown-content">
                    <a href="changePassword.jsp">Change Password</a>
                    <form action="index.jsp" method="post" style="margin: 0;">
                        <button type="submit" class="logout-btn">Logout</button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <div class="container">
        <h2>Welcome to Loans  Dashboard</h2>
        
        <div class="card-container">
        
             <a href="bankApplicationsServlet" class="card">
                <h3>Bank Applications</h3>
            </a>
            
             <a href="customerDetailServlet" class="card">
                <h3>Customers</h3>
            </a>
            
             <a href="admin-customer-loans.jsp" class="card">
                <h3>Loans</h3>
            </a>
            
            
           
           
            
           
        </div>
    </div>
</body>
</html>
