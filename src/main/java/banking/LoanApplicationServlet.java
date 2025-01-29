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

@WebServlet("/LoanApplicationServlet")
@MultipartConfig
public class LoanApplicationServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private String fName = null;


    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve form data
    	
        String loanType = request.getParameter("loanType");
       
        String contactInfo = request.getParameter("contactInfo");
        String address = request.getParameter("address");
        String dob = request.getParameter("dob");
        String adhaarnum = request.getParameter("adhaarnum");
        String proofOfIdentityType = request.getParameter("proofOfIdentityType");
        Part proofOfIdentityFile = request.getPart("proofOfIdentityFile");
        String job = request.getParameter("job");
        String office = request.getParameter("office");
        String salary = request.getParameter("salary");
        Part salaryproof = request.getPart("salaryproof");
        Part income = request.getPart("income");
        String employerContact = request.getParameter("employerContact");
        String loanAmount = request.getParameter("loanAmount");
        String loanTenure = request.getParameter("loanTenure");

        if (Integer.parseInt(loanAmount) < 10000 || Integer.parseInt(loanAmount) > 5000000 ) {
            response.getWriter().println("Loan amount must be between 10,000 and 50,00,000.");
            return;
        }
        if (Integer.parseInt(loanTenure) < 12 || Integer.parseInt(loanTenure) > 72) {
            response.getWriter().println("Loan tenure must be between 12 and 72 months.");
            return;
        }

        // Save fullName for file storage
      

        // Save files to disk
        String proofOfIdentityFilePath = saveFile(proofOfIdentityFile, "proofOfIdentity");
        String salaryProofFilePath = saveFile(salaryproof, "salaryProof");
        String incomeFilePath = saveFile(income, "income");

        // Database connection and data insertion
        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/bankdb", "root", "Layavardhan@2003");

            String query = "INSERT INTO personal_loan_applications (loanType, contactInfo, address, dob, adhaarnum, proofOfIdentityType, proofOfIdentityFile, job, office, salary, salaryProofFile, incomeFile, employerContact, loanAmount, loanTenure,customer_id) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?,?, ?)";
            PreparedStatement pst = con.prepareStatement(query);
            pst.setString(1, loanType);
            pst.setString(2, contactInfo);
            pst.setString(3, address);
            pst.setString(4, dob);
            pst.setString(5, adhaarnum);
            pst.setString(6, proofOfIdentityType);
            pst.setString(7, proofOfIdentityFilePath);
            pst.setString(8, job);
            pst.setString(9, office);
            pst.setString(10, salary);
            pst.setString(11, salaryProofFilePath);
            pst.setString(12, incomeFilePath);
            pst.setString(13, employerContact);
            pst.setString(14, loanAmount);
            pst.setString(15, loanTenure);


           
                // Fetch username from session
                HttpSession session = request.getSession(false);
                String username = (String) session.getAttribute("username");
               

                if (username != null) {
                    // Fetch customer_id using username
                	fName=username;
                    String selectCustomerSQL = "SELECT customer_id FROM customer WHERE username = ?";
                    PreparedStatement selectCustomerPst = con.prepareStatement(selectCustomerSQL);
                    selectCustomerPst.setString(1, username);
                    ResultSet rs = selectCustomerPst.executeQuery();

                    if (rs.next()) {
                        int customerId = rs.getInt("customer_id");
                        pst.setInt(16, customerId);
                        pst.executeUpdate();

                       
                    } else {
                        response.getWriter().println("Customer not found.");
                    }

                    selectCustomerPst.close();
                } else {
                    response.getWriter().println("Session expired. Please log in again.");
                }
            

            pst.close();
            con.close();
            response.sendRedirect("userLoans.jsp");

        }
        catch (ClassNotFoundException | SQLException e) {
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
