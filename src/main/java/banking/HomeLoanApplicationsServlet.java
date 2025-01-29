package banking;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/HomeLoanApplicationsServlet")
public class HomeLoanApplicationsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<HomeLoanApplication> applications = new ArrayList<>();
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/bankdb", "root", "Layavardhan@2003");
            stmt = conn.createStatement();
            String sql = "SELECT * FROM home_loan_applications";
            rs = stmt.executeQuery(sql);

            while (rs.next()) {
                HomeLoanApplication app = new HomeLoanApplication();
                app.setId(rs.getInt("id"));
                app.setFullName(rs.getString("fullName"));
                app.setDob(rs.getDate("dob"));
                app.setGender(rs.getString("gender"));
                app.setMaritalStatus(rs.getString("maritalStatus"));
                app.setNationality(rs.getString("nationality"));
                app.setPanCard(rs.getString("panCard"));
                app.setAadhaarCard(rs.getString("aadhaarCard"));
                app.setContactNumber(rs.getString("contactNumber"));
                app.setEmail(rs.getString("email"));
                app.setOccupation(rs.getString("occupation"));
                app.setMonthlyIncome(rs.getInt("monthlyIncome"));
                app.setProofFilePath(rs.getString("proofFilePath"));
                app.setPropertyAddress(rs.getString("propertyAddress"));
                app.setPropertyType(rs.getString("propertyType"));
                app.setPropertyValue(rs.getInt("propertyValue"));
                app.setTitleDeedFilePath(rs.getString("titleDeedFilePath"));
                app.setTaxReceiptsFilePath(rs.getString("taxReceiptsFilePath"));
                app.setLoanAmount(rs.getInt("loanAmount"));
                app.setLoanTenure(rs.getInt("loanTenure"));
                applications.add(app);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        request.setAttribute("applications", applications);
        request.getRequestDispatcher("/homeLoanApplications.jsp").forward(request, response);
    }
}
