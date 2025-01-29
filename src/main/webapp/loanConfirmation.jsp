<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Loan Application Confirmation</title>
</head>
<body>
    <h2>Loan application submitted successfully.</h2>
    <h3>Uploaded Files:</h3>
    <c:if test="${not empty proofOfIdentityFilePath}">
        <a href="${proofOfIdentityFilePath}" download>Download Proof of Identity</a><br>
        <a href="${proofOfIdentityFilePath}" target="_blank">View Proof of Identity</a><br>
    </c:if>
    <c:if test="${not empty salaryProofFilePath}">
        <a href="${salaryProofFilePath}" download>Download Salary Proof</a><br>
        <a href="${salaryProofFilePath}" target="_blank">View Salary Proof</a><br>
    </c:if>
    <c:if test="${not empty incomeFilePath}">
        <a href="${incomeFilePath}" download>Download Income Tax Certificate</a><br>
        <a href="${incomeFilePath}" target="_blank">View Income Tax Certificate</a><br>
    </c:if>
</body>
</html>
