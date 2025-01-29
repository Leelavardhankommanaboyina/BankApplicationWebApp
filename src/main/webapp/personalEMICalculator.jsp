<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Personal Loan EMI Calculator</title>
    <style>
        body {
            font-family: Arial, sans-serif;
        }
        .container {
            max-width: 600px;
            margin: 0 auto;
            padding: 20px;
            text-align: center;
            border: 1px solid #ccc;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        .header {
            background-color: #e0f7fa;
            padding: 10px;
            border-radius: 8px;
            margin-bottom: 20px;
        }
        .header h1 {
            margin: 0;
        }
        .form-group {
            margin-bottom: 15px;
        }
        .form-group input {
            width: calc(100% - 20px);
            padding: 8px;
            margin: 5px;
        }
        .form-group label {
            display: block;
            margin-bottom: 5px;
        }
        .form-group button {
            padding: 10px 20px;
            background-color: #007bff;
            color: #fff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        .form-group button:hover {
            background-color: #0056b3;
        }
        .results {
            margin-top: 20px;
        }
    </style>
    <script>
        function calculateEMI() {
            var principal = document.getElementById('amount').value;
            var rateOfInterest = document.getElementById('interest').value;
            var tenure = document.getElementById('years').value;

            var monthlyInterestRatio = (rateOfInterest / 100) / 12;
            var tenureMonths = tenure * 12;
            var top = Math.pow((1 + monthlyInterestRatio), tenureMonths);
            var bottom = top - 1;
            var emi = (principal * monthlyInterestRatio * top) / bottom;
            var totalPayment = emi * tenureMonths;
            var totalInterest = totalPayment - principal;

            document.getElementById('emi').innerText = "Monthly EMI: ₹" + emi.toFixed(2);
            document.getElementById('totalPayment').innerText = "Total Payment: ₹" + totalPayment.toFixed(2);
            document.getElementById('totalInterest').innerText = "Total Interest: ₹" + totalInterest.toFixed(2);
        }
    </script>
</head>
<body>
<div class="container">
    <div class="header">
        <h1>Personal Loan EMI Calculator</h1>
        <p>Plan your borrowings and repayments. Calculate your monthly outgo with our personal loan EMI calculator</p>
    </div>
    <div class="form-group">
        <label for="amount">Amount you need</label>
        <input type="number" id="amount" name="amount" value="500000" min="50000" max="4000000">
    </div>
    <div class="form-group">
        <label for="years">Tenure (in years)</label>
        <input type="number" id="years" name="years" value="5" min="1" max="5">
    </div>
    <div class="form-group">
        <label for="interest">Interest rate (%)</label>
        <input type="number" id="interest" name="interest" value="21" min="21" max="21" step="0.1">
    </div>
    <div class="form-group">
        <button type="button" onclick="calculateEMI()">Calculate</button>
    </div>
    <div class="results">
        <p id="emi">Monthly EMI: ₹0.00</p>
        <p id="totalPayment">Total Payment: ₹0.00</p>
        <p id="totalInterest">Total Interest: ₹0.00</p>
    </div>
</div>
</body>
</html>
