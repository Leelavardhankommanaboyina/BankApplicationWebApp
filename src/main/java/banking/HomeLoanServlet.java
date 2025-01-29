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
@WebServlet("/HomeLoanServlet")
@MultipartConfig
public class HomeLoanServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private String fName = null;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Fetch username from session
        HttpSession session = request.getSession(false);
        String username = (String) session.getAttribute("username");
        if (username != null) {
            fName = username;
        } else {
            response.getWriter().println("Session expired. Please log in again.");
            return;
        }

        // Retrieve form data
        String dob = request.getParameter("dob");
        String gender = request.getParameter("gender");
        String maritalStatus = request.getParameter("maritalStatus");
        String nationality = request.getParameter("nationality");
        String panCard = request.getParameter("panCard");
        String aadhaarCard = request.getParameter("aadhaarCard");
        String contactNumber = request.getParameter("contactNumber");
        String email = request.getParameter("email");
        String occupation = request.getParameter("occupation");
        int monthlyIncome = Integer.parseInt(request.getParameter("monthlyIncome"));
        Part proof = request.getPart("proof");
        String propertyAddress = request.getParameter("propertyAddress");
        String propertyType = request.getParameter("propertyType");
        int propertyValue = Integer.parseInt(request.getParameter("propertyValue"));
        Part titleDeed = request.getPart("titleDeed");
        Part taxReceipts = request.getPart("taxReceipts");
        int loanAmount = Integer.parseInt(request.getParameter("loanAmount"));
        int loanTenure = Integer.parseInt(request.getParameter("loanTenure"));

        if (loanAmount < 10000 || loanAmount > 50000000) {
            response.getWriter().println("Loan amount must be between 10,000 and 50,000,000.");
            return;
        }
        if (loanTenure < 12 || loanTenure > 360) {
            response.getWriter().println("Loan tenure must be between 12 and 360 months.");
            return;
        }

        // Save files to disk
        String proofFilePath = saveFile(proof, "proofOfIncome");
        String titleDeedFilePath = saveFile(titleDeed, "titleDeed");
        String taxReceiptsFilePath = saveFile(taxReceipts, "taxReceipts");

        // Database connection and data insertion
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/bankdb", "root", "1082");

            String query = "INSERT INTO home_loan_applications (dob, gender, maritalStatus, nationality, panCard, aadhaarCard, contactNumber, email, occupation, monthlyIncome, proofFilePath, propertyAddress, propertyType, propertyValue, titleDeedFilePath, taxReceiptsFilePath, loanAmount, loanTenure, customer_id) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

            PreparedStatement pst = con.prepareStatement(query);
            pst.setString(1, dob);
            pst.setString(2, gender);
            pst.setString(3, maritalStatus);
            pst.setString(4, nationality);
            pst.setString(5, panCard);
            pst.setString(6, aadhaarCard);
            pst.setString(7, contactNumber);
            pst.setString(8, email);
            pst.setString(9, occupation);
            pst.setInt(10, monthlyIncome);
            pst.setString(11, proofFilePath);
            pst.setString(12, propertyAddress);
            pst.setString(13, propertyType);
            pst.setInt(14, propertyValue);
            pst.setString(15, titleDeedFilePath);
            pst.setString(16, taxReceiptsFilePath);
            pst.setInt(17, loanAmount);
            pst.setInt(18, loanTenure);

            // Fetch customer_id using username
            String selectCustomerSQL = "SELECT customer_id FROM customer WHERE username = ?";
            PreparedStatement selectCustomerPst = con.prepareStatement(selectCustomerSQL);
            selectCustomerPst.setString(1, username);
            ResultSet rs = selectCustomerPst.executeQuery();

            if (rs.next()) {
                int customerId = rs.getInt("customer_id");
                pst.setInt(19, customerId);
                pst.executeUpdate();
                response.sendRedirect("userloans.jsp");
            } else {
                response.getWriter().println("Customer not found.");
            }

            selectCustomerPst.close();
            pst.close();
            con.close();
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        }
    }

    // Method to save file to disk
    private String saveFile(Part filePart, String folderName) throws IOException {
        if (filePart != null && filePart.getSize() > 0) {
            // Extract the file name from the part header
            String fileName = getFileName(filePart);
            if (fileName == null || fileName.isEmpty()) {
                throw new IOException("Invalid file name.");
            }

            // Create the directory if it does not exist
            String folderUser = "C:/Users/layav/OneDrive/Desktop/bank/personalLoanFiles/" + fName + "/";
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