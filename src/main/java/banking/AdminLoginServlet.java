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

@WebServlet("/AdminLoginServlet")
public class AdminLoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = DBUtil.getConnection();

            String query = "SELECT * FROM admin_login WHERE username = ? AND password = ?";
            pstmt = conn.prepareStatement(query);
            pstmt.setString(1, username);
            pstmt.setString(2, password);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                // Admin authenticated, set session attributes
                HttpSession session = request.getSession();
                session.setAttribute("adminUsername", username);

                // Redirect to admin dashboard
                response.sendRedirect("admin-dashboard.jsp"); // Assuming you have admin-dashboard.jsp
            } else {
                // Invalid credentials, redirect back to admin login with error message
                response.sendRedirect("admin-login.jsp?error=InvalidCredentials");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            // Handle database errors
            response.sendRedirect("admin-login.jsp?error=DatabaseError");
        } finally {
            DBUtil.close(conn, pstmt, rs);
        }
    }
}
