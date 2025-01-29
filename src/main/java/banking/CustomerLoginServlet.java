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



@WebServlet("/CustomerLoginServlet")
public class CustomerLoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = DBUtil.getConnection();

            String query = "SELECT * FROM customer WHERE username = ? AND password = ?";
            pstmt = conn.prepareStatement(query);
            pstmt.setString(1, username);
            pstmt.setString(2, password);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                // Customer authenticated, set session attributes
                HttpSession session = request.getSession();
                session.setAttribute("username", username);
                
                // Redirect to customer dashboard or any other page
                response.sendRedirect("customer-dashboard.jsp");
            } else {
                // Invalid credentials, set error message as a request attribute
                request.setAttribute("errorMessage", "Check Your Credentials");
                
                // Forward the request back to the login page
                request.getRequestDispatcher("customer-login.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            // Handle database errors
            request.setAttribute("errorMessage", "Database error. Please try again later.");
            request.getRequestDispatcher("customer-login.jsp").forward(request, response);
        } finally {
            DBUtil.close(conn, pstmt, rs);
        }
    }
}
