package banking;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/AdminLoanStatusServlet")
public class AdminLoanStatusServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String applicationId = request.getParameter("applicationId");
        String action = request.getParameter("action");

        String status = null;
        if ("approve".equals(action)) {
            status = "Approved";
        } else if ("reject".equals(action)) {
            status = "Rejected";
        }

        if (status != null) {
            try {
                Class.forName("com.mysql.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/bankdb", "root", "Layavardhan@2003");

                String updateStatusSQL = "UPDATE personal_loan_applications SET status = ? WHERE id = ?";
                PreparedStatement pst = con.prepareStatement(updateStatusSQL);
                pst.setString(1, status);
                pst.setInt(2, Integer.parseInt(applicationId));

                int rowCount = pst.executeUpdate();
                if (rowCount > 0) {
                    response.getWriter().println("Loan application status updated successfully.");
                } else {
                    response.getWriter().println("Error in updating loan application status.");
                }

                pst.close();
                con.close();
            } catch (ClassNotFoundException | SQLException e) {
                e.printStackTrace();
                response.getWriter().println("Error: " + e.getMessage());
            }
        }
    }
}
