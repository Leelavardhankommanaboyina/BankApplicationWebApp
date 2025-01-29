package banking;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/ChangePasswordServlet")
public class ChangePasswordServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        HttpSession session = request.getSession();
        String username = (String) session.getAttribute("username");

        if (username == null) {
            response.sendRedirect("login.jsp"); // Redirect to login if user is not logged in
            return;
        }

        // Database credentials
        String jdbcURL = "jdbc:mysql://localhost:3306/bankdb";
        String dbUser = "root";
        String dbPassword = "Layavardhan@2003";

        try {
            // Load JDBC driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Connect to the database
            try (Connection connection = DriverManager.getConnection(jdbcURL, dbUser, dbPassword)) {
                // Retrieve current password from the database
                String sql = "SELECT password FROM customer WHERE username = ?";
                try (PreparedStatement statement = connection.prepareStatement(sql)) {
                    statement.setString(1, username);
                    ResultSet resultSet = statement.executeQuery();

                    if (resultSet.next()) {
                        String storedPassword = resultSet.getString("password");

                        // Verify current password
                        if (!storedPassword.equals(currentPassword)) {
                            request.setAttribute("message", "Current password is incorrect.");
                            request.getRequestDispatcher("changePassword.jsp").forward(request, response);
                            return;
                        }

                        // Check if new password and confirm password match
                        if (!newPassword.equals(confirmPassword)) {
                            request.setAttribute("message", "New password and confirm password do not match.");
                            request.getRequestDispatcher("changePassword.jsp").forward(request, response);
                            return;
                        }

                        // Update password in the database
                        sql = "UPDATE customer SET password = ? WHERE username = ?";
                        try (PreparedStatement updateStatement = connection.prepareStatement(sql)) {
                            updateStatement.setString(1, newPassword);
                            updateStatement.setString(2, username);
                            updateStatement.executeUpdate();

                            request.setAttribute("message", "Password successfully changed.");
                            request.getRequestDispatcher("changePassword.jsp").forward(request, response);
                        }
                    } else {
                        request.setAttribute("message", "User not found.");
                        request.getRequestDispatcher("changePassword.jsp").forward(request, response);
                    }
                }
            }
        } catch (ClassNotFoundException | SQLException e) {
            throw new ServletException(e);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("changePassword.jsp");
    }
}