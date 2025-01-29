<!DOCTYPE html>
<html>
<head>
    <title>Verify Your PIN</title>
</head>
<body>
    <h2>Verify Your PIN</h2>
    <form action="VerifyPinServlet" method="post">
        <label for="pin">Enter your PIN:</label>
        <input type="password" id="pin" name="pin" maxlength="4" required>
        <button type="submit">Verify PIN</button>
    </form>
</body>
</html>
