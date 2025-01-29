package banking;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/VerifyOtpServlet")
public class VerifyOtpServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String enteredOtp = request.getParameter("otp");
        HttpSession session = request.getSession();
        int generatedOtp = (int) session.getAttribute("otp");

        if (enteredOtp.equals(String.valueOf(generatedOtp))) {
            // OTP matches
            response.sendRedirect("setNewPassword.jsp");
        } else {
            // OTP doesn't match
            request.setAttribute("error", "Invalid OTP. Please try again.");
            RequestDispatcher rd = request.getRequestDispatcher("verifyOtp.jsp");
            rd.forward(request, response);
        }
    }
}
