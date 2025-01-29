package banking;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String email = request.getParameter("email");
        String fullName = request.getParameter("full_name");
        String phoneNumber = request.getParameter("phone_number");
        String address = request.getParameter("address");
        int age = Integer.parseInt(request.getParameter("age"));

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = DBUtil.getConnection();

            // Check if the username already exists
            String checkQuery = "SELECT username FROM register WHERE username = ?";
            pstmt = conn.prepareStatement(checkQuery);
            pstmt.setString(1, username);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                // Username already exists, redirect back to the registration form with an error message
                response.sendRedirect("registerform.jsp?error=Username already exists");
            } else {
                // Username does not exist, proceed with the registration
                String query = "INSERT INTO register (username, password, email, full_name, phone_number, address, age) VALUES (?, ?, ?, ?, ?, ?, ?)";
                pstmt = conn.prepareStatement(query);
                pstmt.setString(1, username);
                pstmt.setString(2, password);
                pstmt.setString(3, email);
                pstmt.setString(4, fullName);
                pstmt.setString(5, phoneNumber);
                pstmt.setString(6, address);
                pstmt.setInt(7, age);

                int rowCount = pstmt.executeUpdate();
                if (rowCount > 0) {
                    response.sendRedirect("index.jsp?error=Registration success");
                } else {
                    response.sendRedirect("registerform.jsp?error=Registration failed");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("registerform.jsp?error=Registration failed");
        } finally {
            DBUtil.close(conn, pstmt, rs);
        }
    }
}
