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

@WebServlet("/SetPinServlet")
public class SetPinServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String pin = request.getParameter("pin");
        String username = request.getParameter("username");

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            // Database connection details
            String url = "jdbc:mysql://localhost:3306/bankdb";
            String user = "root";
            String password0 = "Layavardhan@2003";

            conn = DriverManager.getConnection(url, user, password0);

            // Retrieve customer_id using the username
            ps = conn.prepareStatement("SELECT customer_id FROM customer WHERE username = ?");
            ps.setString(1, username);
            rs = ps.executeQuery();

            if (rs.next()) {
                int customerId = rs.getInt("customer_id");

                // Update the PIN for the retrieved customer_id
                ps = conn.prepareStatement("UPDATE customer SET pin = ? WHERE customer_id = ?");
                ps.setString(1, pin);
                ps.setInt(2, customerId);
                ps.executeUpdate();

                response.sendRedirect("customer-dashboard.jsp");
            } else {
                response.sendRedirect("setPin.jsp?error=User not found");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("setPin.jsp?error=Unable to set PIN");
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
