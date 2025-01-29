package banking;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import javax.mail.*;
import javax.mail.internet.*;
import java.util.Properties;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/customerDetailServlet.java")
public class customerDetailServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Fetch customers and registers from database
        List<Customer> customers = fetchCustomersFromDB();
        List<Register> registers = fetchRegistersFromDB();

        // Set attributes to be used in JSP
        request.setAttribute("customers", customers);
        request.setAttribute("registers", registers);

        // Forward to admin-dashboard.jsp
        request.getRequestDispatcher("/customer-detail.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");

        if (request.getParameter("accept") != null) {
            acceptCustomer(username);
        } else if (request.getParameter("reject") != null) {
            rejectCustomer(username);
        }

        // Redirect back to doGet to refresh data in adminDashboard.jsp
        response.sendRedirect(request.getContextPath() + "/customer-detail.jsp");
    }

    // Method to accept a customer registration
    private void acceptCustomer(String username) throws ServletException {
        // Database connection parameters
        String url = "jdbc:mysql://localhost:3306/bankdb";
        String user = "root";
        String password0 = "Layavardhan@2003"; // Replace with your database password

        try (Connection connection = DriverManager.getConnection(url, user, password0)) {
            // Fetch data from register table for the given username
            String selectSQL = "SELECT * FROM register WHERE username = ?";
            try (PreparedStatement selectStatement = connection.prepareStatement(selectSQL)) {
                selectStatement.setString(1, username);
                try (ResultSet resultSet = selectStatement.executeQuery()) {
                    if (resultSet.next()) {
                        // Extract data from register table
                        String password = resultSet.getString("password");
                        String email = resultSet.getString("email");
                        String fullName = resultSet.getString("full_name");
                        String phoneNumber = resultSet.getString("phone_number");
                        String address = resultSet.getString("address");
                        int age = resultSet.getInt("age");

                        // Insert into customer table
                        String insertSQL = "INSERT INTO customer (username, password, email, full_name, phone_number, address, age, balance) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
                        try (PreparedStatement insertStatement = connection.prepareStatement(insertSQL)) {
                            insertStatement.setString(1, username);
                            insertStatement.setString(2, password);
                            insertStatement.setString(3, email);
                            insertStatement.setString(4, fullName);
                            insertStatement.setString(5, phoneNumber);
                            insertStatement.setString(6, address);
                            insertStatement.setInt(7, age);
                            insertStatement.setDouble(8, 50000);
                            
                            // Execute the insert query
                            insertStatement.executeUpdate();
                        }

                        // Send acceptance email to the user
                        sendAcceptanceEmail(email, fullName);

                        // Delete from register table after successful insert
                        String deleteSQL = "DELETE FROM register WHERE username = ?";
                        try (PreparedStatement deleteStatement = connection.prepareStatement(deleteSQL)) {
                            deleteStatement.setString(1, username);
                            deleteStatement.executeUpdate();
                        }
                    }
                }
            }
        } catch (SQLException e) {
            throw new ServletException("Database access error", e);
        }
    }

    // Method to reject a customer registration
    private void rejectCustomer(String username) throws ServletException {
        // Database connection parameters
        String url = "jdbc:mysql://localhost:3306/bankdb";
        String user = "root";
        String password = "Layavardhan@2003"; // Replace with your database password

        try (Connection connection = DriverManager.getConnection(url, user, password)) {
            // Delete from register table
            String deleteSQL = "DELETE FROM register WHERE username = ?";
            try (PreparedStatement deleteStatement = connection.prepareStatement(deleteSQL)) {
                deleteStatement.setString(1, username);
                deleteStatement.executeUpdate();
            }
        } catch (SQLException e) {
            throw new ServletException("Database access error", e);
        }
    }

    // Method to fetch customers from the database
    private List<Customer> fetchCustomersFromDB() throws ServletException {
        List<Customer> customers = new ArrayList<>();
        // Database access code to fetch customers from customer table
        String url = "jdbc:mysql://localhost:3306/bankdb";
        String user = "root";
        String password1 = "Layavardhan@2003"; // Replace with your database password

        try (Connection connection = DriverManager.getConnection(url, user, password1)) {
            String selectSQL = "SELECT * FROM customer";
            try (PreparedStatement selectStatement = connection.prepareStatement(selectSQL)) {
                try (ResultSet resultSet = selectStatement.executeQuery()) {
                    while (resultSet.next()) {
                        int customerId = resultSet.getInt("customer_id");
                        String username = resultSet.getString("username");
                        String password = resultSet.getString("password");
                        String email = resultSet.getString("email");
                        String fullName = resultSet.getString("full_name");
                        String phoneNumber = resultSet.getString("phone_number");
                        String address = resultSet.getString("address");
                       
                        int age = resultSet.getInt("age");
                        double balance = resultSet.getDouble("balance");

                        Customer customer = new Customer(customerId, username, password, email, fullName,
                                phoneNumber, address, age, balance);
                        customers.add(customer);
                    }
                }
            }
        } catch (SQLException e) {
            throw new ServletException("Database access error", e);
        }

        return customers;
    }

    // Method to fetch registers from the database
    private List<Register> fetchRegistersFromDB() throws ServletException {
        List<Register> registers = new ArrayList<>();
        // Database access code to fetch registers from register table
        String url = "jdbc:mysql://localhost:3306/bankdb";
        String user = "root";
        String password2 = "Layavardhan@2003"; // Replace with your database password

        try (Connection connection = DriverManager.getConnection(url, user, password2)) {
            String selectSQL = "SELECT * FROM register";
            try (PreparedStatement selectStatement = connection.prepareStatement(selectSQL)) {
                try (ResultSet resultSet = selectStatement.executeQuery()) {
                    while (resultSet.next()) {
                        String username = resultSet.getString("username");
                        String password = resultSet.getString("password");
                        String email = resultSet.getString("email");
                        String fullName = resultSet.getString("full_name");
                        String phoneNumber = resultSet.getString("phone_number");
                        String address = resultSet.getString("address");
                        int age = resultSet.getInt("age");

                        Register register = new Register(username, password, email, fullName, phoneNumber,
                                address, age);
                        registers.add(register);
                    }
                }
            }
        } catch (SQLException e) {
            throw new ServletException("Database access error", e);
        }

        return registers;
    }

    // Method to send acceptance email
    private void sendAcceptanceEmail(String to, String fullName) throws ServletException {
        // Email configuration
        String from = "k.kiran101521@gmail.com"; // Replace with your email
        String host = "smtp.gmail.com"; // Replace with your SMTP server
        final String username = "k.kiran101521@gmail.com"; // Replace with your email username
        final String password = "hltd wnvs lfgo fejb"; // Replace with your email password

        // Set properties
        Properties properties = System.getProperties();
        properties.setProperty("mail.smtp.host", host);
        properties.setProperty("mail.smtp.port", "587");
        properties.setProperty("mail.smtp.auth", "true");
        properties.setProperty("mail.smtp.starttls.enable", "true");
        properties.setProperty("mail.smtp.connectiontimeout", "100000");
        properties.setProperty("mail.smtp.timeout", "100000");
        properties.setProperty("mail.smtp.writetimeout", "100000");

        // Create session
        Session session = Session.getInstance(properties, new javax.mail.Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(username, password);
            }
        });

        try {
            // Create a default MimeMessage object
            MimeMessage message = new MimeMessage(session);

            // Set From: header field
            message.setFrom(new InternetAddress(from));

            // Set To: header field
            message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));

            // Set Subject: header field
            message.setSubject("Account Approved");

            // Set the actual message
            message.setText("Dear " + fullName + ",\n\nYour account has been approved. You can now log in and use our services.\n\nBest regards,\nBank Team");

            // Send message
            Transport.send(message);
            System.out.println("Sent message successfully....");
        } catch (MessagingException mex) {
            mex.printStackTrace();
            throw new ServletException("Email sending failed", mex);
        }
    }
}
