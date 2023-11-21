import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import jakarta.servlet.http.*;
import jakarta.servlet.*;
import java.io.*;

public class authServlet extends HttpServlet {

    public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html");// setting the content type
        PrintWriter pw = response.getWriter();// get the stream to write the data

        String email = request.getParameter("emailInput");
        String password = request.getParameter("passwordInput");

        try {
            Connection connection = dbConnector.getConnection();

            // Prepare the SQL query for authentication
            String sql = "SELECT * FROM users WHERE email=? AND password=?";
            try (PreparedStatement pstmt = connection.prepareStatement(sql)) {
                pstmt.setString(1, email);
                pstmt.setString(2, password);

                // Execute the query
                ResultSet resultSet = pstmt.executeQuery();

                if (resultSet.next()) {
                    // Successful login
                    HttpSession session = request.getSession();
                    session.setAttribute("email", email);
                    session.setAttribute("UserID", resultSet.getInt("UserID"));
                    response.sendRedirect("index.jsp");
                } else {
                    // Failed login
                    response.sendRedirect("login.jsp");
                }
            }

            // Close the database connection
            dbConnector.closeConnection(connection);
        } catch (SQLException e) {
            e.printStackTrace();
            pw.println("<h2>Error: " + e.getMessage() + "</h2>");
        }
        pw.close();// closing the stream
    }
}
