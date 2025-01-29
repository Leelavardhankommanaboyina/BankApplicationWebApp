<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Personal Loan Information</title>
    <link rel="stylesheet" href="styles.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f9fa;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }
        .loan-card {
            width: 350px;
            padding: 20px;
            border: 1px solid #ddd;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            background-color: #fff;
            text-align: center;
            transform: perspective(1000px) rotateY(0deg);
            transition: transform 0.5s;
        }
        .loan-card:hover {
            transform: perspective(1000px) rotateY(10deg);
        }
        .loan-card h2 {
            margin-bottom: 20px;
            color: #007bff;
        }
        .loan-card table {
            width: 100%;
            margin-bottom: 20px;
            border-collapse: collapse;
        }
        .loan-card table, th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: center;
        }
        .loan-card th {
            background-color: #f4f4f4;
        }
        .loan-card tbody tr:hover {
            background-color: #f1f1f1;
        }
        .highlight {
            background-color: #008000;
        }
        .yellow{
         background-color: #FFFF00;
        }
         .red{
         background-color: #ff0000;
        }
        .orange{
         background-color: #FFA500;
        }
        .apply-btn {
            display: inline-block;
            padding: 10px 20px;
            color: #fff;
            background-color: #007bff;
            border: none;
            border-radius: 5px;
            text-decoration: none;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            transition: background-color 0.3s, transform 0.3s;
        }
        .apply-btn:hover {
            background-color: #0056b3;
            transform: translateY(-2px);
        }
    </style>
</head>
<body>
    <div class="loan-card">
        <h2>Personal Loan Information</h2>
        <table>
            <thead>
                <tr>
                    <th>Borrower Credit Rating</th>
                    <th>Score Range</th>
                    <th>Estimated APR</th>
                </tr>
            </thead>
            <tbody>
                <tr class="highlight">
                    <td>Excellent</td>
                    <td>720-850</td>
                    <td>11.85%</td>
                </tr>
                <tr class="orange">
                    <td>Good</td>
                    <td>690-719</td>
                    <td>14.12%</td>
                </tr>
                <tr>
                    <td>Fair</td>
                    <td>630-689</td>
                    <td>18.05%</td>
                </tr>
                <tr class="red">
                    <td>Bad</td>
                    <td>300-629</td>
                    <td>22.68%</td>
                </tr>
            </tbody>
        </table>
        <p class="yellow">Loan tenure: 12 months to 72 months</p>
        <p class="yellow">Minimum loan amount: $1,000</p>
        <p class="yellow">Maximum loan amount: $50,000</p>
        <p class="yellow">No prepayment penalty</p>
        <p class="yellow">Flexible repayment options</p>
        <a href="personalLoan.jsp" class="apply-btn">Apply Now</a>
    </div>
</body>
</html>
