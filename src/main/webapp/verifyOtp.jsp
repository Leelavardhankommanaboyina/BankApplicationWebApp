<!DOCTYPE html>
<html>
<head>
    <title>Verify OTP</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f0f0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }
        .container {
            background-color: white;
            padding: 30px;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            width: 300px;
            text-align: center;
        }
        .form-group {
            margin-bottom: 20px;
        }
        .form-group label {
            display: block;
            margin-bottom: 5px;
        }
        .form-group input {
            width: 100%;
            padding: 10px;
            box-sizing: border-box;
        }
        .form-group button {
            padding: 10px 20px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        .error-message {
            color: red;
            margin-top: 15px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Verify OTP</h2>
        <form action="VerifyOtpServlet" method="post">
            <div class="form-group">
                <label for="otp">Enter OTP</label>
                <input type="text" id="otp" name="otp" required>
            </div>
            <div class="form-group">
                <button type="submit">Verify</button>
            </div>
        </form>

        <% 
            String errorMessage = (String) request.getAttribute("error");
            if (errorMessage != null) {
        %>
            <div class="error-message">
                <%= errorMessage %>
            </div>
        <% } %>
    </div>
</body>
</html>
