package banking;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.RequestDispatcher;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Random;
import javax.servlet.http.HttpSession;
import javax.mail.*;
import javax.mail.internet.*;
import java.util.Properties;

@WebServlet("/SendOtpServlet")
public class SendOtpServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");

        try {
            // Database connection setup
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/bankdb", "root", "Layavardhan@2003");
            String query = "SELECT email FROM customer WHERE username = ?";
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setString(1, username);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                String email = rs.getString("email");

                // Generate a random 4-digit OTP
                Random rand = new Random();
                int otp = rand.nextInt(9999 - 1000) + 1000;

                // Send OTP to email
                String to = email;
                String subject = "Your OTP Code";
                String message = "Your OTP code is: " + otp;

                System.out.println("Sending OTP email to: " + to);
                sendEmail(to, subject, message);

                // Save OTP and username in session
                HttpSession session = request.getSession();
                session.setAttribute("otp", otp);
                session.setAttribute("username", username);

                // Redirect to OTP verification page
                response.sendRedirect("verifyOtp.jsp");
            } else {
                // Handle case when username is not found
                request.setAttribute("error", "Username not found");
                RequestDispatcher rd = request.getRequestDispatcher("forgottenpassword.jsp");
                rd.forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            // Handle the error or provide user feedback
            request.setAttribute("error", "An error occurred. Please try again.");
            RequestDispatcher rd = request.getRequestDispatcher("forgottenpassword.jsp");
            rd.forward(request, response);
        }
    }

    private void sendEmail(String to, String subject, String messageContent) {
        // Set up email server properties
        String from = "layavardhankommanaboyina@gmail.com"; // Replace with your email
        String host = "smtp.gmail.com"; // Replace with your SMTP server
        final String username = "layavardhankommanaboyina@gmail.com"; // Replace with your email username
        final String password = "wqga nose mfje htxu"; // Replace with your email password

        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.timeout", "30000");
        props.put("mail.smtp.connectiontimeout", "30000");
        props.put("mail.debug", "true");

        Session session = Session.getInstance(props, new javax.mail.Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(username, password);
            }
        });


       

        try {
            Message msg = new MimeMessage(session);
            msg.setFrom(new InternetAddress(from));
            msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));
            msg.setSubject(subject);
            msg.setText(messageContent);

            Transport.send(msg);
            System.out.println("Email sent successfully");
        } catch (MessagingException e) {
            e.printStackTrace();
            // Handle the error or provide user feedback
            throw new RuntimeException(e);
        }
    }

}
