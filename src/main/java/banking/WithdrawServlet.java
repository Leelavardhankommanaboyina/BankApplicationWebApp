package banking;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/WithdrawServlet")
public class WithdrawServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String customerIdStr = request.getParameter("customerId");
        if (customerIdStr == null || customerIdStr.isEmpty()) {
            response.sendRedirect("admin-dashboard.jsp?error=CustomerIdNotProvided");
            return;
        }
        
        int customerId = Integer.parseInt(customerIdStr);
        String amountStr = request.getParameter("amount");
        
        if (amountStr == null || amountStr.isEmpty()) {
            response.sendRedirect("admin-dashboard.jsp?error=AmountNotProvided");
            return;
        }
        
        BigDecimal amount = new BigDecimal(amountStr);
        
        if (amount.compareTo(BigDecimal.ZERO) <= 0) {
            response.sendRedirect("admin-dashboard.jsp?error=InvalidAmount");
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
                
                if (currentBalance.compareTo(amount) >= 0) {
                    // Sufficient balance to withdraw
                    BigDecimal newBalance = currentBalance.subtract(amount);
                    
                    // Update balance in database
                    String updateQuery = "UPDATE customer SET balance = ? WHERE customer_id = ?";
                    pstmtUpdate = conn.prepareStatement(updateQuery);
                    pstmtUpdate.setBigDecimal(1, newBalance);
                    pstmtUpdate.setInt(2, customerId);
                    pstmtUpdate.executeUpdate();
                    
                    // Insert transaction details into transactions table
                    String insertTransactionQuery = "INSERT INTO transactions (transaction_time, transaction_type, amount, balance, customer_id) VALUES (?, ?, ?, ?, ?)";
                    pstmtInsertTransaction = conn.prepareStatement(insertTransactionQuery);
                    pstmtInsertTransaction.setTimestamp(1, new Timestamp(System.currentTimeMillis()));
                    pstmtInsertTransaction.setString(2, "Withdrawal");
                    pstmtInsertTransaction.setBigDecimal(3, amount);
                    pstmtInsertTransaction.setBigDecimal(4, newBalance);
                    pstmtInsertTransaction.setInt(5, customerId);
                    pstmtInsertTransaction.executeUpdate();
                    
                    // Redirect with success message
                    response.sendRedirect("admin-dashboard.jsp?message=WithdrawSuccessful");
                } else {
                    // Insufficient balance
                    response.sendRedirect("admin-dashboard.jsp?error=InsufficientBalance");
                }
            } else {
                // Customer not found
                response.sendRedirect("admin-dashboard.jsp?error=CustomerNotFound");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("admin-dashboard.jsp?error=DatabaseError");
        } finally {
            DBUtil.close(conn, pstmtSelect, rs);
            DBUtil.close(conn, pstmtUpdate, null); // pstmtUpdate does not have ResultSet
            DBUtil.close(conn, pstmtInsertTransaction, null); // pstmtInsertTransaction does not have ResultSet
        }
    }
}
