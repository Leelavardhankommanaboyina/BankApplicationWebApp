<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Send Money</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f0f0; /* Background color from the first code block */
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }
        .container {
            background: white; /* Background color from the first code block */
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1); /* Box shadow from the first code block */
            padding: 20px;
            max-width: 400px;
            width: 100%;
            position: relative;
            z-index: 1;
            overflow: hidden;
            transition: transform 0.4s, box-shadow 0.4s;
        }
        .container:hover {
            transform: scale(1.05);
            box-shadow: 0 0 20px rgba(255, 165, 0, 0.8), 0 0 30px rgba(255, 165, 0, 0.6), 0 0 40px rgba(255, 165, 0, 0.4); /* Same hover effect */
        }
        .container:hover::after {
            content: '';
            position: absolute;
            top: -20px;
            left: -20px;
            width: calc(100% + 40px);
            height: calc(100% + 40px);
            border: 2px solid rgba(255, 165, 0, 0.8);
            border-radius: 10px;
            box-shadow: 0 0 20px rgba(255, 165, 0, 0.8), 0 0 30px rgba(255, 165, 0, 0.6), 0 0 40px rgba(255, 165, 0, 0.4);
            animation: spark 1.5s infinite;
            pointer-events: none;
        }
        @keyframes spark {
            0% {
                box-shadow: 0 0 20px rgba(255, 165, 0, 0.8), 0 0 30px rgba(255, 165, 0, 0.6), 0 0 40px rgba(255, 165, 0, 0.4);
            }
            50% {
                box-shadow: 0 0 30px rgba(255, 69, 0, 1), 0 0 40px rgba(255, 69, 0, 0.8), 0 0 50px rgba(255, 69, 0, 0.6);
            }
            100% {
                box-shadow: 0 0 20px rgba(255, 165, 0, 0.8), 0 0 30px rgba(255, 165, 0, 0.6), 0 0 40px rgba(255, 165, 0, 0.4);
            }
        }
        h2 {
            margin: 0 0 20px;
            text-align: center;
            color: #333; /* Adjusted color for visibility */
        }
        form {
            display: flex;
            flex-direction: column;
        }
        input[type="text"] {
            margin-bottom: 15px;
            padding: 10px;
            border: 1px solid #ccc; /* Updated border color */
            border-radius: 5px;
            font-size: 16px;
            background-color: #f9f9f9; /* Updated background color for inputs */
            color: #333; /* Text color */
        }
        input[type="submit"], .back-btn {
            padding: 10px;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s;
            color: #fff;
        }
        input[type="submit"] {
            background-color: #007bff;
            border: none;
        }
        input[type="submit"]:hover {
            background-color: #0056b3;
        }
        .back-btn {
            background-color: #dc3545;
            border: none;
            margin-top: 10px;
        }
        .back-btn:hover {
            background-color: #c82333;
        }
        input[type="text"]::placeholder {
            color: #999; /* Placeholder text color */
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Send Money</h2>
        <form action="enterSendPin.jsp" method="post">
            <input type="text" name="transferToUser" placeholder="Enter Account Username To Send" required>
            <input type="text" name="amount" placeholder="Enter Amount to Send" required>
            <input type="submit" value="Send Money">
        </form>
        <button type="button" class="back-btn" onclick="window.location.href='customer-dashboard.jsp'">Back</button>
    </div>
</body>
</html>
