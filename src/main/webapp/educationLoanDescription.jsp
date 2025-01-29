<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Education Loan Information</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 20px;
        }
        .loan-card {
            background: #fff;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            margin: 20px auto;
            max-width: 600px;
            padding: 20px;
            transition: transform 0.2s, box-shadow 0.2s;
        }
        .loan-card:hover {
            transform: scale(1.05);
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
        }
        .loan-card h2 {
            color: #007BFF;
            text-align: center;
        }
        .loan-card p {
            font-size: 16px;
            line-height: 1.6;
        }
        .highlight {
            background-color: #DFF0D8;
            border-left: 5px solid #5CB85C;
            padding: 10px;
        }
        .apply-button {
            background-color: #007BFF;
            border: none;
            border-radius: 5px;
            color: white;
            cursor: pointer;
            display: block;
            font-size: 18px;
            margin: 20px auto;
            padding: 10px 20px;
            text-align: center;
            text-decoration: none;
            width: 200px;
        }
        .apply-button:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <div class="loan-card">
        <h2>Education Loan Information</h2>
        <div class="highlight">
            <p><strong>Loan Purpose:</strong> Cover expenses related to education such as tuition fees, books, travel, and other educational costs.</p>
            <p><strong>Eligibility Criteria:</strong></p>
            <ul>
                <li>Indian citizen with secured admission to recognized courses in India or abroad.</li>
                <li>Graduation, post-graduation, and professional courses are eligible.</li>
            </ul>
            <p><strong>Loan Amount:</strong> Up to INR 10 lakhs for studies in India and up to INR 20 lakhs for studies abroad.</p>
            <p><strong>Interest Rates:</strong> 8% to 15% based on the bank's MCLR.</p>
            <p><strong>Repayment:</strong> 5 to 15 years, starting 6-12 months after course completion or after securing a job.</p>
            <p><strong>Security:</strong></p>
            <ul>
                <li>No collateral for loans up to INR 4 lakhs.</li>
                <li>Third-party guarantee for loans between INR 4 lakhs and INR 7.5 lakhs.</li>
                <li>Collateral required for loans above INR 7.5 lakhs.</li>
            </ul>
            <p><strong>Credit Score:</strong> Primarily used for assessing guarantor's/co-borrower's creditworthiness, not the primary criterion for loan approval.</p>
            <p><strong>Subsidy Schemes:</strong> Interest subsidy available for economically weaker sections under CSIS.</p>
        </div>
        <a href="educationLoan.jsp" class="apply-button">Apply for Education Loan</a>
    </div>
</body>
</html>
