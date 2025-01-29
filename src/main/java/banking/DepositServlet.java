package banking;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/DepositServlet")
public class DepositServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String customerIdStr = request.getParameter("customerId");

        if (customerIdStr == null || customerIdStr.isEmpty()) {
            // Handle if customerId is not provided
            response.sendRedirect("customer-detail.jsp?error=CustomerIdNotProvided");
            return;
        }

        int customerId = Integer.parseInt(customerIdStr);

        String amountStr = request.getParameter("amount");

        if (amountStr == null || amountStr.isEmpty()) {
            // Handle if amount is not provided
            response.sendRedirect("customer-detail.jsp?error=AmountNotProvided");
            return;
        }

        BigDecimal amount = new BigDecimal(amountStr);

        if (amount.compareTo(BigDecimal.ZERO) <= 0) {
            // Handle if amount is non-positive
            response.sendRedirect("customer-detail.jsp?error=InvalidAmount");
            return;
        }

        Connection conn = null;
        PreparedStatement pstmtSelect = null;
        PreparedStatement pstmtUpdate = null;
        PreparedStatement pstmtInsertTransaction = null;
        ResultSet rs = null;

        try {
            conn = DBUtil.getConnection();

            // Retrieve current balance
            String selectQuery = "SELECT balance FROM customer WHERE customer_id = ?";
            pstmtSelect = conn.prepareStatement(selectQuery);
            pstmtSelect.setInt(1, customerId);
            rs = pstmtSelect.executeQuery();

            if (rs.next()) {
                BigDecimal currentBalance = rs.getBigDecimal("balance");

                // Calculate new balance after deposit
                BigDecimal newBalance = currentBalance.add(amount);

                // Update balance in database
                String updateQuery = "UPDATE customer SET balance = ? WHERE customer_id = ?";
                pstmtUpdate = conn.prepareStatement(updateQuery);
                pstmtUpdate.setBigDecimal(1, newBalance);
                pstmtUpdate.setInt(2, customerId);
                pstmtUpdate.executeUpdate();

                // Insert transaction details into transactions table
                String insertTransactionQuery = "INSERT INTO transactions (transaction_type, amount, balance, customer_id) VALUES (?, ?, ?, ?)";
                pstmtInsertTransaction = conn.prepareStatement(insertTransactionQuery);
                pstmtInsertTransaction.setString(1, "Deposit");
                pstmtInsertTransaction.setBigDecimal(2, amount);
                pstmtInsertTransaction.setBigDecimal(3, newBalance);
                pstmtInsertTransaction.setInt(4, customerId);
                pstmtInsertTransaction.executeUpdate();

                // Redirect with success message
                response.sendRedirect("customer-detail.jsp?message=DepositSuccessful");
            } else {
                // Customer not found (should not happen if customerId parameter is correctly set)
                response.sendRedirect("customer-detail.jsp?error=CustomerNotFound");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("customer-detail.jsp?error=DatabaseError");
        } finally {
            DBUtil.close(conn, pstmtSelect, rs);
            DBUtil.close(conn, pstmtUpdate, null); // pstmtUpdate does not have ResultSet
            DBUtil.close(conn, pstmtInsertTransaction, null); // pstmtInsertTransaction does not have ResultSet
        }
    }
}
