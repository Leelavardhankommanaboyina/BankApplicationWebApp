package banking;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/DepositToFriendServlet")
public class DepositToFriendServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String amountStr = request.getParameter("amount");
        String transferToUser = request.getParameter("transferToUser");

        // Get the logged-in user's username from the session
        HttpSession session = request.getSession();
        String fromUser = (String) session.getAttribute("username");

        if (fromUser == null) {
            response.getWriter().println("User not logged in.");
            return;
        }

        double amount = Double.parseDouble(amountStr);

        try (Connection conn = DBUtil.getConnection()) {
            // Check balance of the logged-in user
            String checkBalanceSql = "SELECT balance FROM customer WHERE username = ?";
            PreparedStatement checkBalanceStmt = conn.prepareStatement(checkBalanceSql);
            checkBalanceStmt.setString(1, fromUser);
            ResultSet rs = checkBalanceStmt.executeQuery();

            if (rs.next()) {
                double currentBalance = rs.getDouble("balance");
                if (currentBalance >= amount) {
                    // Deduct amount from user's account
                    String deductSql = "UPDATE customer SET balance = balance - ? WHERE username = ?";
                    PreparedStatement deductStmt = conn.prepareStatement(deductSql);
                    deductStmt.setDouble(1, amount);
                    deductStmt.setString(2, fromUser);
                    deductStmt.executeUpdate();

                    // Add amount to friend's account
                    String addSql = "UPDATE customer SET balance = balance + ? WHERE username = ?";
                    PreparedStatement addStmt = conn.prepareStatement(addSql);
                    addStmt.setDouble(1, amount);
                    addStmt.setString(2, transferToUser);
                    addStmt.executeUpdate();

                    // Insert transaction into transactionsfrom table
                    String insertTransactionFromSql = "INSERT INTO transactionsfrom (transaction_time, transaction_type, amount, balance, customer_id, username, touser) VALUES (CURRENT_TIMESTAMP, 'Transfer', ?, ?, ?, ?, ?)";
                    PreparedStatement insertTransactionFromStmt = conn.prepareStatement(insertTransactionFromSql);
                    insertTransactionFromStmt.setDouble(1, amount);
                    insertTransactionFromStmt.setDouble(2, currentBalance - amount); // Updated balance after transfer
                    insertTransactionFromStmt.setInt(3, getCustomerId(conn, fromUser)); // Function to get customer_id
                    insertTransactionFromStmt.setString(4, fromUser);
                    insertTransactionFromStmt.setString(5, transferToUser);
                    insertTransactionFromStmt.executeUpdate();

                    // Insert transaction into transactionsfromaccount table
                    String insertTransactionFromAccountSql = "INSERT INTO transactionsfromaccount (transaction_time, transaction_type, amount, balance, customer_id, username, fromuser) VALUES (CURRENT_TIMESTAMP, 'Transfer', ?, ?, ?, ?, ?)";
                    PreparedStatement insertTransactionFromAccountStmt = conn.prepareStatement(insertTransactionFromAccountSql);
                    insertTransactionFromAccountStmt.setDouble(1, amount);
                    insertTransactionFromAccountStmt.setDouble(2, currentBalance - amount); // Updated balance after transfer
                    insertTransactionFromAccountStmt.setInt(3, getCustomerId(conn, fromUser)); // Function to get customer_id
                    insertTransactionFromAccountStmt.setString(4, transferToUser);
                    insertTransactionFromAccountStmt.setString(5, fromUser);
                    
                    insertTransactionFromAccountStmt.executeUpdate();

                    response.sendRedirect("paymentSuccessfully.jsp");
                } else {
                    response.getWriter().println("Insufficient balance.");
                }
            } else {
                response.getWriter().println("User not found.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        }
    }

    private int getCustomerId(Connection conn, String username) throws SQLException {
        String getCustomerIdSql = "SELECT customer_id FROM customer WHERE username = ?";
        PreparedStatement getCustomerIdStmt = conn.prepareStatement(getCustomerIdSql);
        getCustomerIdStmt.setString(1, username);
        ResultSet rs = getCustomerIdStmt.executeQuery();
        if (rs.next()) {
            return rs.getInt("customer_id");
        } else {
            throw new SQLException("Customer ID not found for username: " + username);
        }
    }
}
