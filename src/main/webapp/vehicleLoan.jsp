<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Vehicle Loan Application</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f0f0;
            margin: 0;
            padding: 20px;
        }
        .container {
            background-color: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
            max-width: 600px;
            margin: auto;
        }
        .form-group {
            margin-bottom: 15px;
        }
        .form-group label {
            display: block;
            margin-bottom: 5px;
        }
        .form-group input, .form-group select {
            width: 100%;
            padding: 8px;
            box-sizing: border-box;
        }
        .form-group input[type="file"] {
            padding: 3px;
        }
        .form-group button {
            background-color: #4CAF50;
            color: white;
            padding: 10px 20px;
            border: none;
            cursor: pointer;
            border-radius: 5px;
        }
    </style>
</head>
<body>
    <h2>Vehicle Loan Application Form</h2>
    <div class="container">
        <form action="VehicleLoanServlet" method="post" enctype="multipart/form-data">
           
            <div class="form-group">
                <label for="dob">Date of Birth:</label>
                <input type="date" id="dob" name="dob" required>
            </div>
            <div class="form-group">
                <label for="gender">Gender:</label>
                <select id="gender" name="gender" required>
                    <option value="">Select</option>
                    <option value="male">Male</option>
                    <option value="female">Female</option>
                    <option value="other">Other</option>
                </select>
            </div>
            <div class="form-group">
                <label for="maritalStatus">Marital Status:</label>
                <select id="maritalStatus" name="maritalStatus" required>
                    <option value="">Select</option>
                    <option value="single">Single</option>
                    <option value="married">Married</option>
                    <option value="divorced">Divorced</option>
                    <option value="widowed">Widowed</option>
                </select>
            </div>
            <div class="form-group">
                <label for="nationality">Nationality:</label>
                <input type="text" id="nationality" name="nationality" required>
            </div>
            <div class="form-group">
                <label for="panCard">PAN Card Number:</label>
                <input type="text" id="panCard" name="panCard" required>
            </div>
            <div class="form-group">
                <label for="aadhaarCard">Aadhaar Card Number (optional):</label>
                <input type="text" id="aadhaarCard" name="aadhaarCard">
            </div>
            <div class="form-group">
                <label for="drivingLicense">Driving License Number:</label>
                <input type="text" id="drivingLicense" name="drivingLicense" required>
            </div>
            <div class="form-group">
                <label for="contactNumber">Contact Number:</label>
                <input type="tel" id="contactNumber" name="contactNumber" required>
            </div>
            <div class="form-group">
                <label for="email">Email Address:</label>
                <input type="email" id="email" name="email" required>
            </div>
            <div class="form-group">
                <label for="occupation">Occupation:</label>
                <input type="text" id="occupation" name="occupation" required>
            </div>
            <div class="form-group">
                <label for="monthlyIncome">Monthly Income:</label>
                <input type="number" id="monthlyIncome" name="monthlyIncome" required>
            </div>
            <div class="form-group">
                <label for="proof">Income Proof (PDF format):</label>
                <input type="file" id="proof" name="proof" accept="application/pdf" required>
            </div>
            <div class="form-group">
                <label for="vehicleMake">Vehicle Make:</label>
                <input type="text" id="vehicleMake" name="vehicleMake" required>
            </div>
            <div class="form-group">
                <label for="vehicleModel">Vehicle Model:</label>
                <input type="text" id="vehicleModel" name="vehicleModel" required>
            </div>
            <div class="form-group">
                <label for="vehicleRegistration">Vehicle Registration Number:</label>
                <input type="text" id="vehicleRegistration" name="vehicleRegistration" required>
            </div>
            <div class="form-group">
                <label for="loanAmount">Loan Amount Required:</label>
                <input type="number" id="loanAmount" name="loanAmount" required>
            </div>
            <div class="form-group">
                <label for="loanTenure">Loan Tenure (in months):</label>
                <input type="number" id="loanTenure" name="loanTenure" required>
            </div>
            <div class="form-group">
                <button type="submit">Submit</button>
            </div>
        </form>
    </div>
</body>
</html>
