<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Login</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #121212; /* Dark background */
            text-align: center;
            margin: 0;
            padding: 0;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            overflow: hidden;
            position: relative;
        }
        .container {
            width: 30%;
            padding: 20px;
            background: linear-gradient(45deg, #2c3e50, #3498db);
            border-radius: 10px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.5);
            transition: transform 0.5s ease-in-out, box-shadow 0.5s ease-in-out;
            position: relative;
            z-index: 1;
        }
        .container:hover {
            transform: scale(1.05);
            box-shadow: 0 0 30px rgba(0, 0, 0, 0.7);
        }
        input[type="text"], input[type="password"], input[type="submit"] {
            width: calc(100% - 20px);
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #555; /* Darker border */
            border-radius: 5px;
            font-size: 16px;
            background: #222; /* Dark background for input */
            color: #fff; /* White text for input */
        }
        input[type="submit"] {
            background-color: #007bff;
            color: #fff;
            cursor: pointer;
            transition: background-color 0.3s, transform 0.3s;
        }
        input[type="submit"]:hover {
            background-color: #0056b3;
            transform: scale(1.1);
        }
        @keyframes moveDots {
            0% {
                transform: translateY(0) translateX(0);
            }
            100% {
                transform: translateY(100vh) translateX(100vw);
            }
        }
        .dot {
            width: 10px;
            height: 10px;
            background-color: rgba(255, 0, 150, 0.5);
            border-radius: 50%;
            position: absolute;
            top: -10px;
            left: -10px;
            animation: moveDots 10s linear infinite;
        }
        .dot:nth-child(2) {
            animation-delay: 2s;
            background-color: rgba(0, 204, 255, 0.5);
        }
        .dot:nth-child(3) {
            animation-delay: 4s;
            background-color: rgba(0, 204, 150, 0.5);
        }
        .dot:nth-child(4) {
            animation-delay: 6s;
            background-color: rgba(255, 204, 0, 0.5);
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Admin Login</h2>
        <form action="AdminLoginServlet" method="post">
            <input type="text" name="username" placeholder="Username" required><br>
            <input type="password" name="password" placeholder="Password" required><br>
            <input type="submit" value="Login">
        </form>
    </div>
    <div class="dot"></div>
    <div class="dot"></div>
    <div class="dot"></div>
    <div class="dot"></div>
</body>
</html>