package banking;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Properties;

import javax.mail.*;
import javax.mail.internet.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/LoanApprovalServlet")
public class LoanApprovalServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        String loanType = request.getParameter("loanType");
        int customerId = Integer.parseInt(request.getParameter("customer_id"));
        String applicationDate = request.getParameter("application_date");

        Connection con = null;
        PreparedStatement pst = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/bankdb", "root", "Layavardhan@2003");

            if (action.equals("approve")) {
                // Check if an application with the same loanType and applicationDate is already approved
                String checkApprovalSQL = "SELECT COUNT(*) FROM " + getLoanTable(loanType) + " WHERE status = 'approved' AND application_date = ?";
                pst = con.prepareStatement(checkApprovalSQL);
                pst.setString(1, applicationDate);
                rs = pst.executeQuery();
                rs.next();
                int approvedCount = rs.getInt(1);

                if (approvedCount > 0) {
                    // If an approved application already exists, do not proceed
                    response.getWriter().println("An application for this loan type and date has already been approved.");
                    return;
                }

                // Update loan status to approved
                String updateLoanSQL = "UPDATE " + getLoanTable(loanType) + " SET status = 'approved' WHERE customer_id = ? AND application_date = ?";
                pst = con.prepareStatement(updateLoanSQL);
                pst.setInt(1, customerId);
                pst.setString(2, applicationDate);
                int rowCount = pst.executeUpdate();

                if (rowCount > 0) {
                    // Fetch loan amount
                    String selectLoanSQL = "SELECT loanAmount FROM " + getLoanTable(loanType) + " WHERE customer_id = ? AND application_date = ?";
                    pst = con.prepareStatement(selectLoanSQL);
                    pst.setInt(1, customerId);
                    pst.setString(2, applicationDate);
                    rs = pst.executeQuery();

                    if (rs.next()) {
                        int loanAmount = rs.getInt("loanAmount");

                        // Fetch customer details using customer_id
                        String selectCustomerSQL = "SELECT email, balance FROM customer WHERE customer_id = ?";
                        pst = con.prepareStatement(selectCustomerSQL);
                        pst.setInt(1, customerId);
                        rs = pst.executeQuery();

                        if (rs.next()) {
                            String email = rs.getString("email");
                            double currentBalance = rs.getDouble("balance");

                            // Update customer balance
                            double newBalance = currentBalance + loanAmount;
                            String updateBalanceSQL = "UPDATE customer SET balance = ? WHERE customer_id = ?";
                            pst = con.prepareStatement(updateBalanceSQL);
                            pst.setDouble(1, newBalance);
                            pst.setInt(2, customerId);
                            pst.executeUpdate();

                            // Send approval email
                            sendEmail(email, "Loan Approval", "Your loan has been approved. Please check your account.");
                        }
                    }
                }
            } else {
                // For rejection, simply update the status
                String updateLoanSQL = "UPDATE " + getLoanTable(loanType) + " SET status = 'rejected' WHERE customer_id = ? AND application_date = ?";
                pst = con.prepareStatement(updateLoanSQL);
                pst.setInt(1, customerId);
                pst.setString(2, applicationDate);
                pst.executeUpdate();
            }

            // Redirect back to admin page
            response.sendRedirect("adminLoanManagement.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        } finally {
            try { if (rs != null) rs.close(); } catch (SQLException e) { e.printStackTrace(); }
            try { if (pst != null) pst.close(); } catch (SQLException e) { e.printStackTrace(); }
            try { if (con != null) con.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
    }

    private String getLoanTable(String loanType) {
        switch (loanType) {
            case "Personal Loan": return "personal_loan_applications";
            case "Vehicle Loan": return "vehicle_loan_applications";
            case "Home Loan": return "home_loan_applications";
            case "Education Loan": return "education_loan_applications";
            default: throw new IllegalArgumentException("Invalid loan type: " + loanType);
        }
    }

    private void sendEmail(String to, String subject, String message) {
        // Set up email server properties
        String from = "layavardhankommanaboyina@gmail.com"; // Replace with your email
        String host = "smtp.gmail.com"; // Replace with your SMTP server
        final String username = "layavardhankommanaboyina@gmail.com"; // Replace with your email username
        final String password = "qmdz evnz cfko ycyf"; // Replace with your email password

        // Set properties
        Properties properties = System.getProperties();
        properties.setProperty("mail.smtp.host", host);
        properties.setProperty("mail.smtp.port", "587");
        properties.setProperty("mail.smtp.auth", "true");
        properties.setProperty("mail.smtp.starttls.enable", "true");
        properties.setProperty("mail.smtp.connectiontimeout", "30000");
        properties.setProperty("mail.smtp.timeout", "30000");
        properties.setProperty("mail.smtp.writetimeout", "30000");

        // Create session
        Session session = Session.getInstance(properties, new javax.mail.Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(username, password);
            }
        });

        try {
            Message msg = new MimeMessage(session);
            msg.setFrom(new InternetAddress(from));
            msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));
            msg.setSubject(subject);
            msg.setText(message);

            Transport.send(msg);
            System.out.println("Email sent successfully");
        } catch (MessagingException e) {
            e.printStackTrace();
            // Handle the error or provide user feedback
            throw new RuntimeException(e);
        }
    }
}
