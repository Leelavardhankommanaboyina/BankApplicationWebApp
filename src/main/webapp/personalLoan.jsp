<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Loan Application Form</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f0f0;
            margin: 0;
            padding: 20px;
        }
        .container {
            background-color: white;
            border-radius: 5px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
            margin: auto;
            padding: 20px;
            width: 50%;
        }
        h2 {
            text-align: center;
        }
        .form-group {
            margin-bottom: 15px;
        }
        .form-group label {
            display: block;
            margin-bottom: 5px;
        }
        .form-group input[type="text"], .form-group input[type="date"], .form-group input[type="email"], .form-group input[type="file"], .form-group select {
            width: 100%;
            padding: 8px;
            box-sizing: border-box;
        }
        .form-group input[type="submit"] {
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
            width: 100%;
        }
    </style>
    <script>
        function validateForm() {
            var contactInfo = document.getElementById("contactInfo").value;
            var employerContact = document.getElementById("employerContact").value;
            var adhaarnum = document.getElementById("adhaarnum").value;

            var contactPattern = /^[0-9]{10}$/;
            var adhaarPattern = /^[0-9]{12}$/;

            if (!contactPattern.test(contactInfo)) {
                alert("Please enter a valid 10-digit contact number.");
                return false;
            }

            if (!contactPattern.test(employerContact)) {
                alert("Please enter a valid 10-digit employer contact number.");
                return false;
            }

            if (!adhaarPattern.test(adhaarnum)) {
                alert("Please enter a valid 12-digit Adhaar number.");
                return false;
            }

            return true;
        }
    </script>
</head>
<body>
    <div class="container">
        <h2>Personal Loan Application Form</h2>
        <form action="LoanApplicationServlet" method="post" enctype="multipart/form-data">
            <input type="hidden" name="loanType" value="personal loan">

            <div class="form-group">
                <label for="contactInfo">Contact Information:</label>
                <input type="text" id="contactInfo" name="contactInfo" required>
            </div>
            <div class="form-group">
                <label for="address">Address:</label>
                <input type="text" id="address" name="address" required>
            </div>
            <div class="form-group">
                <label for="dob">Date of Birth:</label>
                <input type="date" id="dob" name="dob" required>
            </div>
            <div class="form-group">
                <label for="adhaarnum">Adhaar Number:</label>
                <input type="text" id="adhaarnum" name="adhaarnum" required>
            </div>
            <div class="form-group">
                <label for="proofOfIdentityType">Proof of Identity:</label>
                <select id="proofOfIdentityType" name="proofOfIdentityType" required>
                    <option value="driver_license">Driver's license</option>
                    <option value="passport">Passport</option>
                    <option value="birth_certificate">Birth certificate</option>
                    <option value="military_id">Military ID</option>
                    <option value="adhaar_card">Adhaar card</option>
                    <option value="state_id">State-issued ID</option>
                </select>
                <input type="file" id="proofOfIdentityFile" name="proofOfIdentityFile" required>
            </div>
            <div class="form-group">
                <label for="job">Job Role:</label>
                <input type="text" id="job" name="job" required>
            </div>
            <div class="form-group">
                <label for="office">Office address:</label>
                <input type="text" id="office" name="office" required>
            </div>
            <div class="form-group">
                <label for="salary">Month Salary:</label>
                <input type="text" id="salary" name="salary" required>
            </div>
            <div class="form-group">
                <label for="salaryproof">Salary Proof:</label>
                <input type="file" id="salaryproof" name="salaryproof" required>
            </div>
            <div class="form-group">
                <label for="income">Income Tax Certificate:</label>
                <input type="file" id="income" name="income" required>
            </div>
            <div class="form-group">
                <label for="employerContact">Employer Contact Information:</label>
                <input type="text" id="employerContact" name="employerContact" required>
            </div>
            <div class="form-group">
                <label for="loanAmount">Enter Loan Amount:</label>
                <input type="text" id="loanAmount" name="loanAmount" required>
            </div>
            <div class="form-group">
                <label for="loanTenure">Enter Loan Tenure:</label>
                <input type="text" id="loanTenure" name="loanTenure" required>
            </div>
            <div class="form-group">
                <input type="submit" value="Apply">
            </div>
        </form>
    </div>
</body>
</html>
