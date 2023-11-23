import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import jakarta.servlet.http.*;
import jakarta.servlet.*;
import java.io.*;

public class profileServlet extends HttpServlet {

    public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html");// setting the content type
        PrintWriter pw = response.getWriter();// get the stream to write the data


        int UserID;
        if(request.getSession().getAttribute("UserID") != null)
        {
            UserID = (int) request.getSession().getAttribute("UserID");
        }
        else{
            UserID = 0;
        }



        if(UserID == 0){
            response.sendRedirect("profile.jsp");
        }else{


        try {
            Connection connection = dbConnector.getConnection();

            String sql = "SELECT items.ItemName, items.RentalPrice, items.ItemCondition\n" +
                  "FROM orders\n" +
                  "JOIN listing ON orders.ListingID = listing.ListingID\n" +
                  "JOIN items ON listing.ItemID = items.ItemID\n" +
                  "WHERE orders.RenterID = ?;";

            
            try (PreparedStatement pstmt = connection.prepareStatement(sql)) {
                pstmt.setInt(1, UserID);
                ResultSet resultSet = pstmt.executeQuery();

                int i = 0;
                while(resultSet.next()){
                    request.setAttribute("ItemName_"+Integer.toString(i), resultSet.getString("ItemName"));
                    request.setAttribute("RentPrice_"+Integer.toString(i), resultSet.getInt("RentalPrice"));
                    request.setAttribute("Cond_"+Integer.toString(i), resultSet.getString("ItemCondition"));
                    i++;
                }
                request.setAttribute("howManyOrder", i);
            }




        // Close the connection using the DatabaseHandler method
        dbConnector.closeConnection(connection);
        } catch (SQLException e) {
            e.printStackTrace();
            pw.println("<h2>Error: " + e.getMessage() + "</h2>");
        }
   
        RequestDispatcher dispatcher = request.getRequestDispatcher("profile.jsp");
        dispatcher.forward(request, response);
    }
        pw.close();// closing the stream
    }
}