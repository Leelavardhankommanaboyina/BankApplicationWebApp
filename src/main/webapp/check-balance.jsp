<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Check Balance</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-size: cover;
            text-align: center;
            margin: 0;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            overflow: hidden; /* Ensure no scrollbars */
        }
        .card {
            width: 30%;
            background-color: rgba(173, 216, 230, 0.5); /* Light blue with transparency */
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            position: relative;
            z-index: 1; /* Ensure the card is above other elements */
            animation: flip 0.1s ease-in-out 2; /* Fast flip animation */
        }
        h2, h3 {
            margin-bottom: 10px;
        }
        .balance {
            font-size: 24px;
            font-weight: bold;
            color: #007bff;
        }
        @keyframes flip {
            0%, 100% {
                transform: rotateY(0);
            }
            50% {
                transform: rotateY(180deg);
            }
        }
        
        @keyframes rupee-fall {
            0% {
                top: -20px;
                left: calc(100% + 20px);
                opacity: 1;
            }
            100% {
                top: calc(50% - 20px);
                left: calc(50% - 20px);
                opacity: 0;
            }
        }
        
        .rupee-container {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            display: flex;
            align-items: center;
            justify-content: center;
            pointer-events: none;
        }
        
        .rupee {
            font-size: 20px;
            color: #007bff;
            position: absolute;
            animation: rupee-fall 2s linear both;
        }
    </style>
</head>
<body>
    <div class="card">
        <h2></h2>
        <h2>Your Current Balance:</h2>
        <p class="balance">₹ <%= request.getAttribute("balance") %></p>
        <br>
        <a href="customer-dashboard.jsp">Back to Dashboard</a>
        <div class="rupee-container">
            <!-- Creating multiple rupee symbols -->
            <% for (int i = 0; i < 1000; i++) { %>
                <span class="rupee">&#8377;</span>
            <% } %>
        </div>
    </div>
</body>
</html>