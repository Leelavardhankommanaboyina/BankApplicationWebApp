
package banking;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

@WebServlet("/VehicleLoanServlet")
@MultipartConfig
public class VehicleLoanServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve form data
        String dob = request.getParameter("dob");
        String gender = request.getParameter("gender");
        String maritalStatus = request.getParameter("maritalStatus");
        String nationality = request.getParameter("nationality");
        String panCard = request.getParameter("panCard");
        String aadhaarCard = request.getParameter("aadhaarCard");
        String drivingLicense = request.getParameter("drivingLicense");
        String contactNumber = request.getParameter("contactNumber");
        String email = request.getParameter("email");
        String occupation = request.getParameter("occupation");
        int monthlyIncome = Integer.parseInt(request.getParameter("monthlyIncome"));
        Part proof = request.getPart("proof");
        String vehicleMake = request.getParameter("vehicleMake");
        String vehicleModel = request.getParameter("vehicleModel");
        String vehicleRegistration = request.getParameter("vehicleRegistration");
        int loanAmount = Integer.parseInt(request.getParameter("loanAmount"));
        int loanTenure = Integer.parseInt(request.getParameter("loanTenure"));

        if (loanAmount < 10000 || loanAmount > 5000000) {
            response.getWriter().println("Loan amount must be between 10,000 and 5,000,000.");
            return;
        }
        if (loanTenure < 12 || loanTenure > 72) {
            response.getWriter().println("Loan tenure must be between 12 and 72 months.");
            return;
        }

        // Save files to disk
        HttpSession session = request.getSession(false);
        String username = (String) session.getAttribute("username");
        if (username == null) {
        	
            response.getWriter().println("Session expired. Please log in again.");
            return;
        }

        String proofFilePath = saveFile(proof, username, "proofOfIncome");

        // Database connection and data insertion
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/bankdb", "root", "Layavardhan@2003");

            // Fetch customer_id using username
            String selectCustomerSQL = "SELECT customer_id FROM customer WHERE username = ?";
            PreparedStatement selectCustomerPst = con.prepareStatement(selectCustomerSQL);
            selectCustomerPst.setString(1, username);
            ResultSet rs = selectCustomerPst.executeQuery();

            if (rs.next()) {
                int customerId = rs.getInt("customer_id");

                String query = "INSERT INTO vehicle_loan_applications (dob, gender, maritalStatus, nationality, panCard, aadhaarCard, drivingLicense, contactNumber, email, occupation, monthlyIncome, proofFilePath, vehicleMake, vehicleModel, vehicleRegistration, loanAmount, loanTenure, customer_id) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?,?)";
                PreparedStatement pst = con.prepareStatement(query);
               
                pst.setString(1, dob);
                pst.setString(2, gender);
                pst.setString(3, maritalStatus);
                pst.setString(4, nationality);
                pst.setString(5, panCard);
                pst.setString(6, aadhaarCard);
                pst.setString(7, drivingLicense);
                pst.setString(8, contactNumber);
                pst.setString(9, email);
                pst.setString(10, occupation);
                pst.setInt(11, monthlyIncome);
                pst.setString(12, proofFilePath);
                pst.setString(13, vehicleMake);
                pst.setString(14, vehicleModel);
                pst.setString(15, vehicleRegistration);
                pst.setInt(16, loanAmount);
                pst.setInt(17, loanTenure);
                pst.setInt(18, customerId);
                int rowCount = pst.executeUpdate();
                if (rowCount > 0) {
                    response.sendRedirect("userLoans.jsp");
                } else {
                    response.getWriter().println("Error in submitting vehicle loan application.");
                }

                pst.close();
            } else {
                response.getWriter().println("Customer not found.");
            }

            selectCustomerPst.close();
            con.close();
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        }
    }

    // Method to save file to disk
    private String saveFile(Part filePart, String username, String folderName) throws IOException {
        if (filePart != null && filePart.getSize() > 0) {
            // Extract the file name from the part header
            String fileName = getFileName(filePart);
            if (fileName == null || fileName.isEmpty()) {
                throw new IOException("Invalid file name.");
            }

            // Create the directory if it does not exist
            String folderUser = "C:/Users/layav/OneDrive/Desktop/bank/vehicleLoanFiles/" + username + "/";
            String directoryPath = folderUser + folderName + "/";
            File directory = new File(directoryPath);
            if (!directory.exists() && !directory.mkdirs()) {
                throw new IOException("Failed to create directory: " + directoryPath);
            }

            // Save the file
            String filePath = directoryPath + fileName;
            File file = new File(filePath);
            try (InputStream inputStream = filePart.getInputStream();
                 FileOutputStream outputStream = new FileOutputStream(file)) {
                byte[] buffer = new byte[1024];
                int bytesRead;
                while ((bytesRead = inputStream.read(buffer)) != -1) {
                    outputStream.write(buffer, 0, bytesRead);
                }
            }
            return filePath;
        }
        return null;
    }

    private String getFileName(Part part) {
        String contentDisposition = part.getHeader("content-disposition");
        String[] items = contentDisposition.split(";");
        for (String item : items) {
            if (item.trim().startsWith("filename")) {
                return item.substring(item.indexOf('=') + 1).trim().replace("\"", "");
            }
        }
        return null;
    }
}
