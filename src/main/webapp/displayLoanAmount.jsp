<%@ page import="java.sql.*, java.util.*, java.text.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Loan Amount</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            flex-direction: column;
            min-height: 100vh;
        }
        .container {
            width: 80%;
            background: white;
            padding: 20px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
            border-radius: 10px;
            text-align: center;
        }
        #loanAmount {
            font-size: 48px;
            margin-bottom: 20px;
            color: #333;
        }
        .button {
            display: inline-block;
            padding: 10px 20px;
            font-size: 16px;
            color: white;
            background-color: #007bff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            text-decoration: none;
        }
        .button:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Loan Amount</h1>
        <div id="loanAmount">
            <%
                String loanAmountStr = request.getParameter("loanAmount");
                if (loanAmountStr != null && !loanAmountStr.isEmpty()) {
                    try {
                        double loanAmount = Double.parseDouble(loanAmountStr);
                        out.println(String.format("%.2f", loanAmount));
                    } catch (NumberFormatException e) {
                        out.println("Invalid loan amount.");
                    }
                } else {
                    out.println("Loan amount not provided.");
                }
            %>
        </div>
        <form method="post" action="enterProcessPin.jsp">
            <input type="hidden" name="loanAmount" value="<%= loanAmountStr %>">
            <input type="hidden" name="loanType" value="<%= request.getParameter("loanType") %>">
            <input type="hidden" name="applicationDate" value="<%= request.getParameter("applicationDate") %>">
            <button type="submit" class="button">Pay</button>
        </form>
    </div>
</body>
</html>
