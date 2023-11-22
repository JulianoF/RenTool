import java.sql.Connection;
import java.sql.SQLException;
import java.sql.PreparedStatement;

import jakarta.servlet.http.*;
import jakarta.servlet.*;
import java.io.*;

public class creationServlet extends HttpServlet {

    public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html");// setting the content type
        PrintWriter pw = response.getWriter();// get the stream to write the data

        String email = request.getParameter("email");
        String fname = request.getParameter("fname");
        String lname = request.getParameter("lname");
        String password = request.getParameter("password");
        String country = request.getParameter("country");
        String province = request.getParameter("province");
        String city = request.getParameter("city");
        String postal = request.getParameter("postal");
        

        try {
            Connection connection = dbConnector.getConnection();

            String sql = "INSERT INTO users (Email, FirstName, LastName, Password, Country, Province, City, PostalCode) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
            try (PreparedStatement pstmt = connection.prepareStatement(sql)) {
                pstmt.setString(1, email);
                pstmt.setString(2, fname);
                pstmt.setString(3, lname);
                pstmt.setString(4, password);
                pstmt.setString(5, country);
                pstmt.setString(6, province);
                pstmt.setString(7, city);
                pstmt.setString(8, postal);

                // Execute the query
                int rowsAffected = pstmt.executeUpdate();

                if (rowsAffected > 0) {
                    response.sendRedirect("/RenTool/jsp/login.jsp");
                } else {
                    response.sendRedirect("/RenTool/jsp/accCreation.jsp");
                }

                 // Close the connection using the DatabaseHandler method
                dbConnector.closeConnection(connection);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            pw.println("<h2>Error: " + e.getMessage() + "</h2>");
        }
        pw.close();// closing the stream
    }
}
