<table>
    <thead>
        <tr>
            <th>Loan Type</th>
            <th>Loan Amount</th>
            <th>Loan Tenure</th>
            <th>Status</th>
        </tr>
    </thead>
    <tbody>
        <c:forEach var="loan" items="${userLoans}">
            <tr>
                <td>${loan.loanType}</td>
                <td>${loan.loanAmount}</td>
                <td>${loan.loanTenure}</td>
                <td>${loan.status}</td>
            </tr>
        </c:forEach>
    </tbody>
</table>
