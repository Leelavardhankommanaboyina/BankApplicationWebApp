package banking;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class CheckPinServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String enteredPin = request.getParameter("pin");
        String action = request.getParameter("action"); // New action parameter
        HttpSession session = request.getSession();
        String username = (String) session.getAttribute("username");

        if (username == null || enteredPin == null) {
            response.sendRedirect("setPin.jsp");
            return;
        }

        try {
            String url = "jdbc:mysql://localhost:3306/bankdb";
            String user = "root";
            String password0 = "Layavardhan@2003";
            Connection con = DriverManager.getConnection(url, user, password0);
            String query = "SELECT customer_id, pin FROM customer WHERE username = ?";
            PreparedStatement statement = con.prepareStatement(query);
            statement.setString(1, username);
            ResultSet resultSet = statement.executeQuery();

            if (resultSet.next()) {
                int customerId = resultSet.getInt("customer_id");
                String storedPin = resultSet.getString("pin");

                if (storedPin == null) {
                    response.sendRedirect("setPin.jsp");
                } else if (enteredPin.equals(storedPin)) {
                    // PIN matches, handle different actions
                    if ("checkBalance".equals(action)) {
                        response.sendRedirect("CheckBalanceServlet");
                    } else if ("sendMoney".equals(action)) {
                        response.sendRedirect("DepositToFriendServlet");
                    } else {
                        // Handle unknown actions or default action
                        response.sendRedirect("dashboard.jsp");
                    }
                } else {
                    // PIN doesn't match, show error message
                    request.setAttribute("errorMessage", "You have entered the wrong PIN. Please re-enter.");
                    request.getRequestDispatcher("enterPin.jsp").forward(request, response);
                }
            } else {
                // User not found, handle error
                response.sendRedirect("login.jsp");
            }
        } catch (SQLException e) {
            throw new ServletException("Database error", e);
        }
    }
}
