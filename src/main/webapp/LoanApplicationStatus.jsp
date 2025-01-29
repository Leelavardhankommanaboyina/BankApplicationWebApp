<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Loan Applications</title>
    <style>
        table {
            width: 100%;
            border-collapse: collapse;
        }
        table, th, td {
            border: 1px solid black;
        }
        th, td {
            padding: 10px;
            text-align: left;
        }
        th {
            background-color: #f2f2f2;
        }
        .status-approved {
            color: green;
        }
        .status-rejected {
            color: red;
        }
    </style>
</head>
<body>
    <h2>Loan Applications</h2>
    <table>
        <tr>
            <th>Full Name</th>
            <th>Loan Amount</th>
            <th>Loan Tenure</th>
            <th>Application Date</th>
            <th>Status</th>
            <th>Action</th>
        </tr>
        <c:forEach var="application" items="${applications}">
            <tr>
                <td>${application.fullName}</td>
                <td>${application.loanAmount}</td>
                <td>${application.loanTenure} months</td>
                <td>${application.applicationDate}</td>
                <td class="${application.status == 'Approved' ? 'status-approved' : 'status-rejected'}">
                    ${application.status}
                </td>
                <td>
                    <form action="LoanApplicationStatusServlet" method="post">
                        <input type="hidden" name="applicationId" value="${application.id}">
                        <button type="submit" name="status" value="Approved">Approve</button>
                        <button type="submit" name="status" value="Rejected">Reject</button>
                    </form>
                </td>
            </tr>
        </c:forEach>
    </table>
</body>
</html>
