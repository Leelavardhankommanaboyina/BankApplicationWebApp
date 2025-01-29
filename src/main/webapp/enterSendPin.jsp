<!DOCTYPE html>
<html lang="en">
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
            padding: 40px;
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

        .pin-container input[type="submit"], .pin-container button {
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

        .pin-container input[type="submit"]:hover, .pin-container button:hover {
            background-color: #0056b3;
        }

       
    </style>
</head>
<body>
    <div class="pin-container">
        <h2>Enter Your PIN</h2>
        <form action="DepositToFriendServlet" method="post">
            <!-- Hidden fields to pass data from the previous page -->
            <input type="hidden" name="transferToUser" value="<%= request.getParameter("transferToUser") %>">
            <input type="hidden" name="amount" value="<%= request.getParameter("amount") %>">
            <!-- PIN input field -->
            <input type="password" name="pin" placeholder="Enter your PIN" required>
            <input type="submit" value="Confirm">
            
        </form>
    </div>
</body>
</html>
