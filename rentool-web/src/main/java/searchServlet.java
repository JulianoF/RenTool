import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.PreparedStatement;

import jakarta.servlet.http.*;
import jakarta.servlet.*;
import java.io.*;

public class searchServlet extends HttpServlet {

    public void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        res.setContentType("text/html");// setting the content type
        PrintWriter pw = res.getWriter();// get the stream to write the data

        String searchQuery = req.getParameter("searchField");

        // SQL CODE HERE

        try {
            Connection connection = dbConnector.getConnection();

            // Prepare the SQL query for authentication
            String sql = "SELECT items.*, listing.*\n" +
                         "FROM items\n" +
                         "LEFT JOIN listing ON items.ItemID = listing.ItemID\n" +
                         "WHERE items.ItemName LIKE '%?%'\n" +
                         "LIMIT 4\n" +
                         "UNION\n" +
                         "SELECT items.*, listing.*\n" +
                         "FROM items\n" +
                         "LEFT JOIN listing ON items.ItemID = listing.ItemID\n" +
                         "WHERE items.ItemID NOT IN (\n" +
                         "    SELECT ItemID\n" +
                         "    FROM items\n" +
                         "    WHERE ItemName LIKE '%h?%'\n" +
                         ")\n" +
                         "LIMIT 4;";
            try (PreparedStatement pstmt = connection.prepareStatement(sql)) {
                pstmt.setString(1, searchQuery);
                

                // Execute the query
                ResultSet resultSet = pstmt.executeQuery();

                int i = 0;
                while(resultSet.next() || i < 3){
                    req.setAttribute("", searchQuery);
                    i++;
                }
            }

            // Close the database connection
            dbConnector.closeConnection(connection);
        } catch (SQLException e) {
            e.printStackTrace();
            pw.println("<h2>Error: " + e.getMessage() + "</h2>");
        }        

        req.setAttribute("resultMessage", searchQuery);

        RequestDispatcher dispatcher = req.getRequestDispatcher("searchResults.jsp");
        dispatcher.forward(req, res);

        pw.close();// closing the stream
    }
}