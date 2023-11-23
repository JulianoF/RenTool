import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import jakarta.servlet.http.*;
import jakarta.servlet.*;
import java.io.*;

public class orderServlet extends HttpServlet {

    public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html");// setting the content type
        PrintWriter pw = response.getWriter();// get the stream to write the data


        String itemName =  (String) request.getSession().getAttribute("ItemName");
        int UserID = (int) request.getSession().getAttribute("UserID");
        String dateListed = (String) request.getSession().getAttribute("DateListed");



        if(UserID == 0){
            response.sendRedirect("index.jsp");
        }


        try {
            Connection connection = dbConnector.getConnection();

            String sql = 
            "INSERT INTO orders (ListingID, OwnerID, RenterID, DateRented, Price)\n" +
            "SELECT\n" +
            "    l.ListingID,\n" +
            "    i.UserID AS OwnerID,\n" +
            "    ? AS RenterID,\n" +
            "    ? AS DateRented,\n" +
            "    i.RentalPrice\n" +
                "FROM\n" +
            "    items i\n" +
            "JOIN\n" +
            "    listing l ON i.ItemID = l.ItemID\n" +
            "WHERE\n" +
            "    i.ItemName = ?";

            try (PreparedStatement pstmt = connection.prepareStatement(sql)) {
                pstmt.setInt(1, UserID);
                pstmt.setString(2, dateListed);
                pstmt.setString(3, itemName);

                int rowsAffected = pstmt.executeUpdate();
                if (rowsAffected > 0) {
                    response.sendRedirect("orderPage.jsp");
                } else {
                    response.sendRedirect("index.jsp");
                }
            }




        // Close the connection using the DatabaseHandler method
        dbConnector.closeConnection(connection);
        } catch (SQLException e) {
            e.printStackTrace();
            pw.println("<h2>Error: " + e.getMessage() + "</h2>");
        }
   
        pw.close();// closing the stream
    }
}