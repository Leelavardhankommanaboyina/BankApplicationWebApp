package banking;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Properties;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

// other imports

@WebServlet("/LoanApplicationStatusServlet")
public class LoanApplicationStatusServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String applicationId = request.getParameter("applicationId");
        String status = request.getParameter("status");

        updateApplicationStatus(applicationId, status);
        response.sendRedirect(request.getContextPath() + "/LoanApplicationStatusServlet");
    }

    private void updateApplicationStatus(String applicationId, String status) throws ServletException {
        String url = "jdbc:mysql://localhost:3306/bankdb";
        String user = "root";
        String password = "Layavardhan@2003";
        String customerEmail = null;

        try (Connection connection = DriverManager.getConnection(url, user, password)) {
            String updateSQL = "UPDATE personal_loan_applications SET status = ? WHERE id = ?";
            try (PreparedStatement updateStatement = connection.prepareStatement(updateSQL)) {
                updateStatement.setString(1, status);
                updateStatement.setString(2, applicationId);
                updateStatement.executeUpdate();
            }

            // Retrieve customer's email from customer table based on applicationId
            String emailSQL = "SELECT email FROM customer WHERE username = ?";
            try (PreparedStatement emailStatement = connection.prepareStatement(emailSQL)) {
                emailStatement.setString(1, applicationId);
                try (ResultSet resultSet = emailStatement.executeQuery()) {
                    if (resultSet.next()) {
                        customerEmail = resultSet.getString("email");
                    }
                }
            }

            if (customerEmail != null) {
                sendEmail(customerEmail, status);
            }
        } catch (SQLException e) {
            throw new ServletException("Database access error", e);
        }
    }

    private void sendEmail(String recipientEmail, String status) {
        final String username = ""; // replace with your email
        final String password = "wqga nose mfje htxu"; // replace with your email password

        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");

        Session session = Session.getInstance(props,
            new javax.mail.Authenticator() {
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(username, password);
                }
            });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress("layavardhankommanaboyina@gmail.com"));
            message.setRecipients(Message.RecipientType.TO,
                InternetAddress.parse(recipientEmail));
            message.setSubject("Loan Application Status");

            if ("approved".equalsIgnoreCase(status)) {
                message.setText("Your loan amount was approved. Check your balance.");
            } else if ("rejected".equalsIgnoreCase(status)) {
                message.setText("Your loan amount was rejected. Check your details.");
            }

            Transport.send(message);

        } catch (MessagingException e) {
            throw new RuntimeException(e);
        }
    }
}
