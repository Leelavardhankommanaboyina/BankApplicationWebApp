package banking;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/TransactionHistoryServlet")
public class TransactionHistoryServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String username = (String) session.getAttribute("username");

        if (username == null) {
            response.sendRedirect("customer-login.jsp");
            return;
        }

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        List<Transaction> transactionList = new ArrayList<>();
        List<Transaction> transactionFromList = new ArrayList<>();
        List<Transaction> transactionFromAccountList = new ArrayList<>();

        try {
            conn = DBUtil.getConnection();
            System.out.println("Connected to database.");

            // Retrieve all details related to the current customer's transactions table
            String selectQuery = "SELECT * FROM transactions WHERE username = ?";
            pstmt = conn.prepareStatement(selectQuery);
            pstmt.setString(1, username);
            System.out.println("Executing query: " + selectQuery + " with username=" + username);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                int transactionId = rs.getInt("transaction_id");
                Timestamp transactionTime = rs.getTimestamp("transaction_time");
                String transactionType = rs.getString("transaction_type");
                BigDecimal amount = rs.getBigDecimal("amount");
                BigDecimal balance = rs.getBigDecimal("balance");

                // Format timestamp to String for display
                String formattedTime = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(transactionTime);

                Transaction transaction = new Transaction(transactionId, formattedTime, transactionType, amount, balance, username, null);
                transactionList.add(transaction);
            }

            rs.close();
            pstmt.close();

            // Retrieve all details related to the current customer's transactionsfrom table
            selectQuery = "SELECT * FROM transactionsfrom WHERE username = ?";
            pstmt = conn.prepareStatement(selectQuery);
            pstmt.setString(1, username);
            System.out.println("Executing query: " + selectQuery + " with username=" + username);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                int transactionId = rs.getInt("transaction_id");
                Timestamp transactionTime = rs.getTimestamp("transaction_time");
                String transactionType = rs.getString("transaction_type");
                BigDecimal amount = rs.getBigDecimal("amount");
                BigDecimal balance = rs.getBigDecimal("balance");
                String toUser = rs.getString("touser");

                // Format timestamp to String for display
                String formattedTime = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(transactionTime);

                Transaction transaction = new Transaction(transactionId, formattedTime, transactionType, amount, balance, username, toUser);
                transactionFromList.add(transaction);
            }

            rs.close();
            pstmt.close();

            // Retrieve all details related to the current customer's transactionsfromaccount table
            selectQuery = "SELECT * FROM transactionsfromaccount WHERE username = ?";
            pstmt = conn.prepareStatement(selectQuery);
            pstmt.setString(1, username);
            System.out.println("Executing query: " + selectQuery + " with username=" + username);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                int transactionId = rs.getInt("transaction_id");
                Timestamp transactionTime = rs.getTimestamp("transaction_time");
                String transactionType = rs.getString("transaction_type");
                BigDecimal amount = rs.getBigDecimal("amount");
                BigDecimal balance = rs.getBigDecimal("balance");
                String toUser = rs.getString("fromuser");
                System.out.println(toUser);
                // Format timestamp to String for display
                String formattedTime = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(transactionTime);

                Transaction transaction = new Transaction(transactionId, formattedTime, transactionType, amount, balance, username, toUser);
                transactionFromAccountList.add(transaction);
            }

            // Set transactionList, transactionFromList, and transactionFromAccountList as request attributes
            request.setAttribute("transactionList", transactionList);
            request.setAttribute("transactionFromList", transactionFromList);
            request.setAttribute("transactionFromAccountList", transactionFromAccountList);
            request.getRequestDispatcher("transaction-history.jsp").forward(request, response);

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("customer-dashboard.jsp?error=DatabaseError");
        } finally {
            DBUtil.close(conn, pstmt, rs);
            System.out.println("Database resources closed.");
        }
    }
}
