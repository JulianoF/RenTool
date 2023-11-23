import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.PreparedStatement;

import jakarta.servlet.http.*;
import jakarta.servlet.*;
import java.io.*;
import javax.naming.*;

public class searchServlet extends HttpServlet {

    public void doPost(HttpServletRequest request, HttpServletResponse res)
            throws ServletException, IOException {
        res.setContentType("text/html");// setting the content type
        PrintWriter pw = res.getWriter();// get the stream to write the data

        String searchQuery = request.getParameter("searchField");


        try {
            Connection connection = dbConnector.getConnection();

            String sql = "SELECT items.*, listing.*\n" +
                         "FROM items\n" +
                         "LEFT JOIN listing ON items.ItemID = listing.ItemID\n" +
                         "WHERE items.ItemName LIKE ?\n" +
                         "   OR items.ItemID IN (\n" +
                         "       SELECT ItemID\n" +
                         "       FROM items\n" +
                         "       WHERE ItemName LIKE ?\n" +
                         "   )\n" +
                         "UNION\n" +
                         "SELECT items.*, listing.*\n" +
                         "FROM items\n" +
                         "LEFT JOIN listing ON items.ItemID = listing.ItemID\n" +
                         "WHERE NOT EXISTS (\n" +
                         "    SELECT 1\n" +
                         "    FROM items\n" +
                         "    WHERE ItemName LIKE ?\n" +
                         ")\n" +
                         "LIMIT 4;";
            try (PreparedStatement pstmt = connection.prepareStatement(sql)) {
                pstmt.setString(1, "%" + searchQuery + "%");
                pstmt.setString(2, "%" + searchQuery + "%");
                pstmt.setString(3, "%" + searchQuery + "%");
                

                // Execute the query
                ResultSet resultSet = pstmt.executeQuery();

                int i = 0;
                while(resultSet.next()){
                    byte[] imageData = resultSet.getBytes("ProductImage");
                    if(imageData != null){
                        request.setAttribute("ImageData_"+Integer.toString(i), imageData);
                    }
                    request.setAttribute("itemID_"+Integer.toString(i), resultSet.getInt("ItemID"));
                    request.setAttribute("UserID_"+Integer.toString(i), resultSet.getInt("UserID"));
                    request.setAttribute("ItemName_"+Integer.toString(i), resultSet.getString("ItemName"));
                    request.setAttribute("Desc_"+Integer.toString(i), resultSet.getString("Description"));
                    request.setAttribute("RentalPrice_"+Integer.toString(i), resultSet.getInt("RentalPrice"));
                    request.setAttribute("Condition_"+Integer.toString(i), resultSet.getString("ItemCondition"));
                    request.setAttribute("DateListed_"+Integer.toString(i), resultSet.getString("DateListed"));
                    int id = (int) resultSet.getInt("UserID");

                    String sql2 = "SELECT * FROM location WHERE UserID_Location = "+id+";";
                    try(PreparedStatement pstmt2 = connection.prepareStatement(sql2)){
                        ResultSet resultSet2 = pstmt2.executeQuery();
                        if(resultSet2.next()){
                            request.setAttribute("long_"+Integer.toString(i), resultSet2.getDouble("longitude"));
                            request.setAttribute("lat_"+Integer.toString(i), resultSet2.getDouble("latitude"));
                        }
                        else{
                            request.setAttribute("long_"+Integer.toString(i), 0.0);
                            request.setAttribute("lat_"+Integer.toString(i), 0.0);                           
                        }
                    }
                    i++;
                }
                request.setAttribute("howManyResults", i);
            }


            // Close the database connection
            dbConnector.closeConnection(connection);
        } catch (SQLException | NamingException e) {
            e.printStackTrace();
            pw.println("<h2>Error: " + e.getMessage() + "</h2>");
        }        


        RequestDispatcher dispatcher = request.getRequestDispatcher("searchResults.jsp");
        dispatcher.forward(request, res);

        pw.close();// closing the stream
    }
}