package banking;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

// Define the servlet URL pattern
@WebServlet("/EducationLoanApplicationsServlet")
public class EducationLoanApplicationsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // Database URL, username, and password
    private static final String DB_URL = "jdbc:mysql://localhost:3306/bankdb";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "Layavardhan@2003";

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<EducationLoanApplication> applications = new ArrayList<>();
        
        try (Connection connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            String query = "SELECT * FROM education_loan_applications";
            try (PreparedStatement statement = connection.prepareStatement(query);
                 ResultSet resultSet = statement.executeQuery()) {

                while (resultSet.next()) {
                    EducationLoanApplication application = new EducationLoanApplication();
                    application.setId(resultSet.getInt("id"));
                    application.setFullName(resultSet.getString("fullName"));
                    application.setContactInfo(resultSet.getString("contactInfo"));
                    application.setAddress(resultSet.getString("address"));
                    application.setDob(resultSet.getDate("dob"));
                    application.setAadhaarNumber(resultSet.getString("aadhaarNumber"));
                    application.setAcademicRecords(resultSet.getString("academicRecords"));
                    application.setAdmissionLetter(resultSet.getString("admissionLetter"));
                    application.setFeeStructure(resultSet.getString("feeStructure"));
                    application.setEntranceExamScores(resultSet.getString("entranceExamScores"));
                    application.setCoBorrowerName(resultSet.getString("coBorrowerName"));
                    application.setCoBorrowerRelationship(resultSet.getString("coBorrowerRelationship"));
                    application.setCoBorrowerIncomeProof(resultSet.getString("coBorrowerIncomeProof"));
                    application.setLoanAmount(resultSet.getDouble("loanAmount"));
                    application.setApplicationDate(resultSet.getTimestamp("applicationDate"));
                    
                    applications.add(application);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        request.setAttribute("applications", applications);
        request.getRequestDispatcher("/educationLoanApplications.jsp").forward(request, response);
    }
}
