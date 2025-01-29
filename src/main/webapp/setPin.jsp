<!DOCTYPE html>
<html>
<head>
    <title>Set Your PIN</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f7f9fc;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .container {
            background-color: #ffffff;
            padding: 20px 40px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            text-align: center;
        }

        h2 {
            color: #333;
            margin-bottom: 20px;
        }

        label {
            display: block;
            margin-bottom: 10px;
            font-size: 16px;
            color: #555;
        }

        input[type="password"] {
            width: 100%;
            padding: 10px;
            margin-bottom: 20px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 16px;
            box-sizing: border-box;
        }

        button {
            background-color: #007bff;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        button:hover {
            background-color: #0056b3;
        }

        /* Responsive design */
        @media (max-width: 480px) {
            .container {
                padding: 20px;
                width: 90%;
            }

            input[type="password"], button {
                font-size: 14px;
                padding: 8px;
            }
        }
    </style>
</head>
<body>
 <% 
        String username = (String) session.getAttribute("username");
    %>
    <div class="container">
        <h2>Set Your PIN</h2>
        <form action="SetPinServlet" method="post">
            <label for="pin">Enter a 4-digit PIN:</label>
            <input type="password" id="pin" name="pin" maxlength="4" required>
            <input type="hidden" name="username" value="<%= username %>">
            <button type="submit">Set PIN</button>
        </form>
    </div>
</body>
</html>
