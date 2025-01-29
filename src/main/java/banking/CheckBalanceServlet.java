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

@WebServlet("/CheckBalanceServlet")
public class CheckBalanceServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String username = (String) session.getAttribute("username");

        if (username == null) {
            response.sendRedirect("customer-login.jsp");
            return;
        }

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = DBUtil.getConnection();

            // Query to fetch the balance of the logged-in user
            String query = "SELECT balance FROM customer WHERE username = ?";
            pstmt = conn.prepareStatement(query);
            pstmt.setString(1, username);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                double balance = rs.getDouble("balance");
                request.setAttribute("balance", balance);
            } else {
                request.setAttribute("balance", "Balance not found.");
            }

            // Forward to check-balance.jsp
            request.getRequestDispatcher("check-balance.jsp").forward(request, response);

        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("balance", "Error retrieving balance.");
            request.getRequestDispatcher("check-balance.jsp").forward(request, response);
        } finally {
            DBUtil.close(conn, pstmt, rs);
        }
    }
}
