<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Education Loan Application Form</title>
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
        .form-group input[type="text"], .form-group input[type="date"], .form-group input[type="file"], .form-group select {
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
</head>
<body>
    <div class="container">
        <h2>Education Loan Application Form</h2>
        <form action="EducationLoanApplicationServlet" method="post" enctype="multipart/form-data">
            <!-- Personal Information -->
            <div class="form-group">
                <label for="fullName">Full Name:</label>
                <input type="text" id="fullName" name="fullName" required>
            </div>
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
                <label for="aadhaarNumber">Aadhaar Number:</label>
                <input type="text" id="aadhaarNumber" name="aadhaarNumber" required>
            </div>

            <!-- Academic Information -->
            <div class="form-group">
                <label for="academicRecords">Academic Records (10th, 12th, Degree):</label>
                <input type="file" id="academicRecords" name="academicRecords" required>
            </div>
            <div class="form-group">
                <label for="admissionLetter">Admission Letter:</label>
                <input type="file" id="admissionLetter" name="admissionLetter" required>
            </div>
            <div class="form-group">
                <label for="feeStructure">Fee Structure:</label>
                <input type="file" id="feeStructure" name="feeStructure" required>
            </div>
            <div class="form-group">
                <label for="entranceExamScores">Entrance Exam Scores (if applicable):</label>
                <input type="file" id="entranceExamScores" name="entranceExamScores">
            </div>

            <!-- Co-borrower/Guarantor Information -->
            <div class="form-group">
                <label for="coBorrowerName">Co-borrower/Guarantor Name:</label>
                <input type="text" id="coBorrowerName" name="coBorrowerName" required>
            </div>
            <div class="form-group">
                <label for="coBorrowerRelationship">Relationship with Co-borrower:</label>
                <input type="text" id="coBorrowerRelationship" name="coBorrowerRelationship" required>
            </div>
            <div class="form-group">
                <label for="coBorrowerIncomeProof">Co-borrower Income Proof:</label>
                <input type="file" id="coBorrowerIncomeProof" name="coBorrowerIncomeProof" required>
            </div>

            <!-- Loan Details -->
            <div class="form-group">
                <label for="loanAmount">Loan Amount:</label>
                <input type="text" id="loanAmount" name="loanAmount" required>
            </div>

            <!-- Submit Button -->
            <div class="form-group">
                <input type="submit" value="Apply">
            </div>
        </form>
    </div>
</body>
</html>
