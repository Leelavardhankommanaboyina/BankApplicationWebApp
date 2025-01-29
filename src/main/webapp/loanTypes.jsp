<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Loan Types</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f0f0;
            margin: 0;
            padding: 20px;
        }
        .container {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
        }
        .card {
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
            margin: 15px;
            padding: 20px;
            width: 200px;
            height: 300px;
            text-align: center;
            transition: transform 0.4s, box-shadow 0.4s;
            overflow: hidden;
            position: relative;
        }
        .card img {
            width: 100%;
            height: 150px;
            border-radius: 10px;
        }
        .card h3 {
            margin: 15px 0;
        }
        .card input[type="submit"] {
            background-color: #4CAF50;
            border: none;
            color: white;
            padding: 10px 20px;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            font-size: 16px;
            margin-top: 10px;
            cursor: pointer;
            border-radius: 5px;
        }
        .card:hover {
            transform: scale(1.05);
            box-shadow: 0 0 20px rgba(255, 165, 0, 0.8), 0 0 30px rgba(255, 165, 0, 0.6), 0 0 40px rgba(255, 165, 0, 0.4);
        }
        .card:hover::after {
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
    </style>
</head>
<body>
    <h2>Select Loan Type</h2>
    <div class="container">
        <form action="personalLoanDescription.jsp" method="get">
            <div class="card">
                <img src="personalLoan.jpeg" alt="Personal Loan">
                <h3>Personal Loan</h3>
                <input type="hidden" name="loanType" value="personal">
                <input type="submit" value="Select">
            </div>
        </form>
        <form action="educationLoanDescription.jsp" method="post">
            <div class="card">
                <img src="educationLoan.jpeg" alt="Education Loan">
                <h3>Education Loan</h3>
                <input type="hidden" name="loanType" value="education">
                <input type="submit" value="Select">
            </div>
        </form>
        <form action="vehicleLoan.jsp" method="post">
            <div class="card">
                <img src="vehicleLoan.jpeg" alt="Vehicle Loan">
                <h3>Vehicle Loan</h3>
                <input type="hidden" name="loanType" value="vehicle">
                <input type="submit" value="Select">
            </div>
        </form>
        <form action="homeLoan.jsp" method="post">
            <div class="card">
                <img src="homeLoan.jpeg" alt="Home Loan">
                <h3>Home Loan</h3>
                <input type="hidden" name="loanType" value="home">
                <input type="submit" value="Select">
            </div>
        </form>
    </div>
</body>
</html>
